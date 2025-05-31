// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import 'package:provider/provider.dart';
import '../../app_state.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class UploadSelfie extends StatefulWidget {
  const UploadSelfie({
    super.key,
    this.width,
    this.height,
    required this.userId,
  });

  final double? width;
  final double? height;
  final String userId;

  @override
  State<UploadSelfie> createState() => _UploadSelfieState();
}

class _UploadSelfieState extends State<UploadSelfie> {
  File? _selfieImageFile;
  String? _selfieImageUrl;
  bool _isUploading = false;
  bool _isProcessing = false;
  String? _errorMessage;
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    _loadExistingSelfie();
  }

  Future<void> _loadExistingSelfie() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('selfies')
          .doc(widget.userId)
          .get();

      if (doc.exists) {
        setState(() {
          _selfieImageUrl = doc.data()?['imageUrl'];
          _isVerified = doc.data()?['isVerified'] ?? false;
        });
      }
    } catch (e) {
      print('Error loading existing selfie: $e');
    }
  }

  Future<void> _showImageSourceBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Take Selfie',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _captureSelfie();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickSelfie();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _captureSelfie() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.front,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (pickedFile != null) {
        await Future.delayed(const Duration(seconds: 1));

        setState(() {
          _selfieImageFile = File(pickedFile.path);
          _errorMessage = null;
        });

        await _verifyAndUploadSelfie();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to capture selfie: $e';
      });
    }
  }

  Future<void> _pickSelfie() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        setState(() {
          _selfieImageFile = File(pickedFile.path);
          _errorMessage = null;
        });

        await _verifyAndUploadSelfie();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to pick selfie: $e';
      });
    }
  }

  Future<bool> _verifySelfie(File imageFile) async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final inputImage = InputImage.fromFile(imageFile);
      final faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          enableClassification: true,
          enableLandmarks: true,
          enableTracking: true,
          minFaceSize: 0.01,
          performanceMode: FaceDetectorMode.fast,
        ),
      );

      final faces = await faceDetector.processImage(inputImage);
      await faceDetector.close();

      if (faces.isEmpty) {
        final retryDetector = FaceDetector(
          options: FaceDetectorOptions(
            enableClassification: false,
            enableLandmarks: false,
            enableTracking: false,
            minFaceSize: 0.01,
            performanceMode: FaceDetectorMode.accurate,
          ),
        );

        final retryFaces = await retryDetector.processImage(inputImage);
        await retryDetector.close();

        if (retryFaces.isEmpty) {
          setState(() {
            _errorMessage =
                'Unable to detect face. Please try again with better lighting.';
          });
          return false;
        }
        return true;
      } else if (faces.length > 1) {
        setState(() {
          _errorMessage =
              'Multiple faces detected. Please take a selfie with only your face.';
        });
        return false;
      }

      final face = faces.first;
      if (face.headEulerAngleY != null && face.headEulerAngleY! > 45) {
        setState(() {
          _errorMessage = 'Please face the camera more directly.';
        });
        return false;
      }

      return true;
    } catch (e) {
      print('Error verifying selfie: $e');
      setState(() {
        _errorMessage = 'Error processing selfie. Please try again.';
      });
      return false;
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _verifyAndUploadSelfie() async {
    if (_selfieImageFile == null) return;

    final isHuman = await _verifySelfie(_selfieImageFile!);
    if (!isHuman) {
      setState(() {
        _selfieImageFile = null;
      });
      return;
    }

    await _uploadSelfieToFirebase();
  }

  Future<void> _uploadSelfieToFirebase() async {
    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    try {
      // Delete existing selfie if it exists
      if (_selfieImageUrl != null) {
        try {
          final existingRef =
              FirebaseStorage.instance.refFromURL(_selfieImageUrl!);
          await existingRef.delete();
        } catch (e) {
          print('Error deleting existing selfie: $e');
        }
      }

      // Upload new selfie
      final fileName =
          '${widget.userId}_selfie_${DateTime.now().millisecondsSinceEpoch}${path.extension(_selfieImageFile!.path)}';
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('selfies/${widget.userId}/$fileName');

      final uploadTask = await storageRef.putFile(_selfieImageFile!);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Update Firestore
      await FirebaseFirestore.instance
          .collection('selfies')
          .doc(widget.userId)
          .set({
        'uid': widget.userId,
        'imageUrl': downloadUrl,
        'isVerified': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      setState(() {
        _selfieImageUrl = downloadUrl;
        _isVerified = true;
      });
    } catch (e) {
      print('Error uploading selfie: $e');
      setState(() {
        _errorMessage = 'Failed to upload selfie: $e';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            const Text(
              'Selfie Verification',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Subtitle
            const Text(
              'Take a clear selfie for identity verification',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Selfie Preview
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isVerified ? Colors.green : Colors.grey.shade300,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: _isUploading && _selfieImageFile != null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _selfieImageUrl != null
                        ? Image.network(
                            _selfieImageUrl!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red.shade400,
                                      size: 48,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Failed to load image',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.face,
                                  color: Colors.grey.shade400,
                                  size: 48,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'No selfie uploaded',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
            ),
            const SizedBox(height: 32),
            // Capture button
            GestureDetector(
              onTap: (_isProcessing || _isUploading)
                  ? null
                  : () => _showImageSourceBottomSheet(),
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: (_isProcessing || _isUploading)
                      ? Colors.grey.shade300
                      : Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: (_isProcessing || _isUploading)
                    ? const Center(child: CircularProgressIndicator())
                    : const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 36,
                      ),
              ),
            ),
            const SizedBox(height: 32),
            // Verification status
            if (_isVerified)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green.shade600,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Selfie Verified',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            // Error message
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red.shade900),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
