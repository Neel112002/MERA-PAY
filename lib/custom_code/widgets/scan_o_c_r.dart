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

import 'package:provider/provider.dart';
import '../../app_state.dart';

import 'index.dart'; // Imports other custom widgets

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ScanOCR extends StatefulWidget {
  const ScanOCR({
    super.key,
    this.width,
    this.height,
    required this.userId,
    required this.documentType, // 1 = Aadhaar, 2 = PAN, 3 = Payslip
  });

  final double? width;
  final double? height;
  final String userId;
  final int documentType;

  @override
  State<ScanOCR> createState() => _ScanOCRState();
}

class _ScanOCRState extends State<ScanOCR> {
  File? _frontImageFile;
  File? _backImageFile;
  String? _frontImageUrl;
  String? _backImageUrl;
  String? _ocrText;
  Map<String, dynamic> _parsedData = {};
  bool _isProcessing = false;
  bool _isUploading = false;
  String? _errorMessage;
  bool _isFrontCaptured = false;
  int _currentPayslipMonth = 0; // 0, 1, 2 for three months
  bool _isVerified = false;
  Map<String, dynamic> _extractedFields = {};

  String get _documentTypeString {
    switch (widget.documentType) {
      case 1:
        return 'aadhaar_cards';
      case 2:
        return 'pan_cards';
      case 3:
        return 'payslips';
      default:
        return 'aadhaar_cards';
    }
  }

  String get _documentTitle {
    switch (widget.documentType) {
      case 1:
        return 'Aadhaar Card Verification';
      case 2:
        return 'PAN Card Verification';
      case 3:
        return 'Payslip Verification';
      default:
        return 'Document Verification';
    }
  }

  String get _frontSideText {
    switch (widget.documentType) {
      case 1:
        return 'Take a photo of the front side of your Aadhaar card.';
      case 2:
        return 'Take a photo of the front side of your PAN card.';
      case 3:
        return 'Take a photo of your payslip for ${_getPayslipMonthText()}.';
      default:
        return 'Take a photo of the front side.';
    }
  }

  String get _backSideText {
    switch (widget.documentType) {
      case 1:
        return 'Now capture the back side of your Aadhaar card.';
      case 2:
        return 'Now capture the back side of your PAN card.';
      case 3:
        return 'Payslip has only one side.';
      default:
        return 'Now capture the back side.';
    }
  }

  String _getPayslipMonthText() {
    final now = DateTime.now();
    final month = now.month - _currentPayslipMonth;
    final year = now.year - (month <= 0 ? 1 : 0);
    final adjustedMonth = month <= 0 ? month + 12 : month;
    return '${_getMonthName(adjustedMonth)} $year';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  bool get _requiresBackSide {
    return widget.documentType == 1 ||
        widget.documentType == 2; // Aadhaar and PAN require back side
  }

  bool get _isPayslip {
    return widget.documentType == 3;
  }

  @override
  void initState() {
    super.initState();
    _loadExistingImages();
  }

  Future<void> _loadExistingImages() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(_documentTypeString)
          .doc(widget.userId)
          .get();

      if (doc.exists) {
        if (_isPayslip) {
          // For payslips, load the current month's image
          final month = _currentPayslipMonth + 1;
          final monthImageUrl = doc.data()?['month${month}ImageUrl'];

          setState(() {
            _frontImageUrl = monthImageUrl;
            _isFrontCaptured = monthImageUrl != null;
          });

          if (monthImageUrl != null) {
            try {
              final frontImage = await _downloadImage(monthImageUrl);
              if (frontImage != null) {
                await _performOCR(frontImage, frontImage);
              }
            } catch (e) {
              print('Error processing payslip image: $e');
              _resetAppState();
            }
          }
        } else {
          // For other documents
          final frontImageUrl = doc.data()?['frontImageUrl'];
          final backImageUrl = doc.data()?['backImageUrl'];

          setState(() {
            _frontImageUrl = frontImageUrl;
            _backImageUrl = backImageUrl;
            _isFrontCaptured = frontImageUrl != null;
          });

          // If we have both images (for Aadhaar/PAN) or front image (for Payslip), process them
          if ((_requiresBackSide &&
                  frontImageUrl != null &&
                  backImageUrl != null) ||
              (!_requiresBackSide && frontImageUrl != null)) {
            try {
              // Download images
              final frontImage = await _downloadImage(frontImageUrl);
              final backImage =
                  _requiresBackSide ? await _downloadImage(backImageUrl) : null;

              if (frontImage != null &&
                  (!_requiresBackSide || backImage != null)) {
                // Process images through OCR
                final frontInputImage = InputImage.fromFile(frontImage);
                final textRecognizer = TextRecognizer();
                final frontRecognizedText =
                    await textRecognizer.processImage(frontInputImage);

                String combinedText = frontRecognizedText.text;
                if (_requiresBackSide && backImage != null) {
                  final backInputImage = InputImage.fromFile(backImage);
                  final backRecognizedText =
                      await textRecognizer.processImage(backInputImage);
                  combinedText += '\n${backRecognizedText.text}';
                }

                await textRecognizer.close();

                final parsedData = _parseFields(combinedText);
                final extractedNumber = _getDocumentNumber(parsedData);

                print("🔍 Extracted Number: $extractedNumber");

                // Update AppState based on extracted number
                FFAppState().update(() {
                  if (extractedNumber != null && extractedNumber.isNotEmpty) {
                    _updateAppState(extractedNumber);
                  } else {
                    _resetAppState();
                  }
                });

                // Update Firestore with document-specific data
                final documentData = {
                  'documentNumber': extractedNumber ?? '',
                  'isVerified':
                      extractedNumber != null && extractedNumber.isNotEmpty,
                  'updatedAt': FieldValue.serverTimestamp(),
                };

                // Add document-specific fields
                if (widget.documentType == 2) {
                  // PAN Card
                  documentData['panNumber'] = extractedNumber ?? '';
                  documentData['panVerification'] =
                      extractedNumber != null && extractedNumber.isNotEmpty;
                }

                await FirebaseFirestore.instance
                    .collection(_documentTypeString)
                    .doc(widget.userId)
                    .set(documentData, SetOptions(merge: true));

                print(
                    "📱 Updated Document Number in AppState: ${_getAppStateNumber()}");
                print("✅ Verification Status: ${_getAppStateVerification()}");
              }
            } catch (e) {
              print('Error processing images: $e');
              _resetAppState();
            }
          }
        }
      }
    } catch (e) {
      print('Error loading existing images: $e');
      _resetAppState();
    }
  }

  String? _getDocumentNumber(Map<String, dynamic> parsedData) {
    switch (widget.documentType) {
      case 1:
        return parsedData['AadhaarNumber'] as String?;
      case 2:
        return parsedData['PANNumber'] as String?;
      case 3:
        return parsedData['employeeNumber'] as String?;
      default:
        return null;
    }
  }

  void _updateAppState(String number) {
    switch (widget.documentType) {
      case 1:
        FFAppState().aadharNumber = number;
        FFAppState().aadharverification = true;
        break;
      case 2:
        FFAppState().panNumber = number;
        FFAppState().panverification = true;
        break;
      case 3:
        FFAppState().payslipNumber = number;
        FFAppState().payslipverification = true;
        break;
    }
  }

  void _resetAppState() {
    switch (widget.documentType) {
      case 1:
        FFAppState().aadharNumber = '';
        FFAppState().aadharverification = false;
        break;
      case 2:
        FFAppState().panNumber = '';
        FFAppState().panverification = false;
        break;
      case 3:
        FFAppState().payslipNumber = '';
        FFAppState().payslipverification = false;
        break;
    }
  }

  String _getAppStateNumber() {
    switch (widget.documentType) {
      case 1:
        return FFAppState().aadharNumber;
      case 2:
        return FFAppState().panNumber;
      case 3:
        return FFAppState().payslipNumber;
      default:
        return '';
    }
  }

  bool _getAppStateVerification() {
    switch (widget.documentType) {
      case 1:
        return FFAppState().aadharverification;
      case 2:
        return FFAppState().panverification;
      case 3:
        return FFAppState().payslipverification;
      default:
        return false;
    }
  }

  Future<File?> _downloadImage(String imageUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);
      final tempDir = await getTemporaryDirectory();
      final fileName = path.basename(imageUrl);
      final file = File('${tempDir.path}/$fileName');

      if (await file.exists()) {
        return file;
      }

      await ref.writeToFile(file);
      return file;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

  Future<String> _uploadImageToFirebase(File imageFile, String side) async {
    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    try {
      // Delete existing image if it exists
      if (side == 'front' && _frontImageUrl != null) {
        try {
          final existingRef =
              FirebaseStorage.instance.refFromURL(_frontImageUrl!);
          await existingRef.delete();
        } catch (e) {
          print('Error deleting existing front image: $e');
        }
      } else if (side == 'back' && _backImageUrl != null) {
        try {
          final existingRef =
              FirebaseStorage.instance.refFromURL(_backImageUrl!);
          await existingRef.delete();
        } catch (e) {
          print('Error deleting existing back image: $e');
        }
      }

      // If uploading front image, reset back image
      if (side == 'front' && _requiresBackSide) {
        if (_backImageUrl != null) {
          try {
            final backRef = FirebaseStorage.instance.refFromURL(_backImageUrl!);
            await backRef.delete();
          } catch (e) {
            print('Error deleting back image: $e');
          }
        }
        setState(() {
          _backImageUrl = null;
          _backImageFile = null;
        });
      }

      // Upload new image
      final fileName =
          '${widget.userId}_${side}_${DateTime.now().millisecondsSinceEpoch}${path.extension(imageFile.path)}';
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('${_documentTypeString}/${widget.userId}/$fileName');

      final uploadTask = await storageRef.putFile(imageFile);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Update Firestore with the image URL and uid
      if (_isPayslip) {
        // For payslips, store with month prefix
        final month = _currentPayslipMonth + 1;
        await FirebaseFirestore.instance
            .collection(_documentTypeString)
            .doc(widget.userId)
            .set({
          'uid': widget.userId, // Add uid
          'month${month}ImageUrl': downloadUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } else {
        // For other documents
        await FirebaseFirestore.instance
            .collection(_documentTypeString)
            .doc(widget.userId)
            .set({
          'uid': widget.userId, // Add uid
          '${side}ImageUrl': downloadUrl,
          if (side == 'front' && _requiresBackSide) 'backImageUrl': null,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      // Update state with new image URL
      setState(() {
        if (side == 'front') {
          _frontImageUrl = downloadUrl;
          _frontImageFile = imageFile;
        } else {
          _backImageUrl = downloadUrl;
          _backImageFile = imageFile;
        }
      });

      // If we have both images (for Aadhaar) or front image (for PAN/Payslip), perform OCR
      if ((_requiresBackSide &&
              _frontImageFile != null &&
              _backImageFile != null) ||
          (!_requiresBackSide && _frontImageFile != null)) {
        if (_requiresBackSide) {
          await _performOCR(_frontImageFile!, _backImageFile!);
        } else {
          await _performOCR(_frontImageFile!, _frontImageFile!);
        }
      }

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      setState(() {
        _errorMessage = 'Failed to upload image: $e';
      });
      throw Exception('Failed to upload image: $e');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _showImageSourceBottomSheet(bool isFrontSide) async {
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
              Text(
                isFrontSide ? 'Upload Front Side' : 'Upload Back Side',
                style: const TextStyle(
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
                  _captureImage(isFrontSide);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(isFrontSide);
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text('Upload File'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile(isFrontSide);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _captureImage(bool isFrontSide) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        setState(() {
          if (isFrontSide) {
            _frontImageFile = File(pickedFile.path);
            _isFrontCaptured = true;
          } else {
            _backImageFile = File(pickedFile.path);
          }
          _errorMessage = null;
        });

        // Upload to Firebase
        final side = isFrontSide ? 'front' : 'back';
        final imageFile = isFrontSide ? _frontImageFile! : _backImageFile!;
        final imageUrl = await _uploadImageToFirebase(imageFile, side);

        setState(() {
          if (isFrontSide) {
            _frontImageUrl = imageUrl;
          } else {
            _backImageUrl = imageUrl;
          }
        });

        if (_isPayslip) {
          // For payslips, move to next month after successful upload
          if (_currentPayslipMonth < 2) {
            setState(() {
              _currentPayslipMonth++;
              _frontImageUrl = null;
              _frontImageFile = null;
              _isFrontCaptured = false;
            });
            // Load the next month's image if it exists
            await _loadExistingImages();
          }
        } else if (isFrontSide && _backImageUrl == null && _requiresBackSide) {
          // For other documents that require back side
          await Future.delayed(const Duration(milliseconds: 500));
          _showImageSourceBottomSheet(false);
        } else if (!isFrontSide && _frontImageUrl != null) {
          // Process both images for other documents
          await _performOCR(_frontImageFile!, _backImageFile!);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to capture image: $e';
      });
    }
  }

  Future<void> _pickImage(bool isFrontSide) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        setState(() {
          if (isFrontSide) {
            _frontImageFile = File(pickedFile.path);
            _isFrontCaptured = true;
          } else {
            _backImageFile = File(pickedFile.path);
          }
          _errorMessage = null;
        });

        // Upload to Firebase
        final side = isFrontSide ? 'front' : 'back';
        final imageFile = isFrontSide ? _frontImageFile! : _backImageFile!;
        final imageUrl = await _uploadImageToFirebase(imageFile, side);

        setState(() {
          if (isFrontSide) {
            _frontImageUrl = imageUrl;
          } else {
            _backImageUrl = imageUrl;
          }
        });

        if (_isPayslip) {
          // For payslips, move to next month after successful upload
          if (_currentPayslipMonth < 2) {
            setState(() {
              _currentPayslipMonth++;
              _frontImageUrl = null;
              _frontImageFile = null;
              _isFrontCaptured = false;
            });
            // Load the next month's image if it exists
            await _loadExistingImages();
          }
        } else if (isFrontSide && _backImageUrl == null && _requiresBackSide) {
          // For other documents that require back side
          await Future.delayed(const Duration(milliseconds: 500));
          _showImageSourceBottomSheet(false);
        } else if (!isFrontSide && _frontImageUrl != null) {
          // Process both images for other documents
          await _performOCR(_frontImageFile!, _backImageFile!);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to pick image: $e';
      });
    }
  }

  Future<void> _pickFile(bool isFrontSide) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.first.path!);
        setState(() {
          if (isFrontSide) {
            _frontImageFile = file;
            _isFrontCaptured = true;
          } else {
            _backImageFile = file;
          }
          _errorMessage = null;
        });

        // Upload to Firebase
        final side = isFrontSide ? 'front' : 'back';
        final imageFile = isFrontSide ? _frontImageFile! : _backImageFile!;
        final imageUrl = await _uploadImageToFirebase(imageFile, side);

        setState(() {
          if (isFrontSide) {
            _frontImageUrl = imageUrl;
          } else {
            _backImageUrl = imageUrl;
          }
        });

        if (_isPayslip) {
          // For payslips, move to next month after successful upload
          if (_currentPayslipMonth < 2) {
            setState(() {
              _currentPayslipMonth++;
              _frontImageUrl = null;
              _frontImageFile = null;
              _isFrontCaptured = false;
            });
            // Load the next month's image if it exists
            await _loadExistingImages();
          }
        } else if (isFrontSide && _backImageUrl == null && _requiresBackSide) {
          // For other documents that require back side
          await Future.delayed(const Duration(milliseconds: 500));
          _showImageSourceBottomSheet(false);
        } else if (!isFrontSide && _frontImageUrl != null) {
          // Process both images for other documents
          await _performOCR(_frontImageFile!, _backImageFile!);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to pick file: $e';
      });
    }
  }

  Future<void> _performOCR(File frontImage, File backImage) async {
    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    try {
      // Process front image
      final frontInputImage = InputImage.fromFile(frontImage);
      final textRecognizer = TextRecognizer();
      final frontRecognizedText =
          await textRecognizer.processImage(frontInputImage);

      String combinedText = frontRecognizedText.text;

      // For payslips, only one side is needed
      await textRecognizer.close();

      final parsedData = _parseFields(combinedText);
      print('Extracted payslip fields:');
      print(parsedData);

      // Save to Firestore for payslips
      if (_isPayslip) {
        print('Saving payslip fields to Firestore...');
        await _saveToFirestore(parsedData);
      } else {
        // Existing Aadhaar and PAN logic
        final extractedNumber = _getDocumentNumber(parsedData);
        print("🔍 Extracted Number: $extractedNumber");
        FFAppState().update(() {
          if (extractedNumber != null && extractedNumber.isNotEmpty) {
            _updateAppState(extractedNumber);
          } else {
            _resetAppState();
          }
        });
        final documentData = {
          'documentNumber': extractedNumber ?? '',
          'isVerified': extractedNumber != null && extractedNumber.isNotEmpty,
          'updatedAt': FieldValue.serverTimestamp(),
        };
        if (widget.documentType == 2) {
          documentData['panNumber'] = extractedNumber ?? '';
          documentData['panVerification'] =
              extractedNumber != null && extractedNumber.isNotEmpty;
        }
        await FirebaseFirestore.instance
            .collection(_documentTypeString)
            .doc(widget.userId)
            .set(documentData, SetOptions(merge: true));
        print(
            "📱 Updated Document Number in AppState: ${_getAppStateNumber()}");
        print("✅ Verification Status: ${_getAppStateVerification()}");
      }

      setState(() {
        _ocrText = combinedText;
        _parsedData = parsedData;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'OCR processing failed: $e';
      });
      _resetAppState();
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _saveToFirestore(Map<String, dynamic> fields) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection(_documentTypeString)
          .doc(widget.userId);

      if (widget.documentType == 3) {
        // Payslip
        final month = _currentPayslipMonth + 1;
        final monthPrefix = 'month$month';
        final payslipData = <String, dynamic>{
          'uid': widget.userId, // Add uid
          '${monthPrefix}ImageUrl': _frontImageUrl,
          // '${monthPrefix}IsVerified': false, // Set to false on upload
          '${monthPrefix}UpdatedAt': FieldValue.serverTimestamp(),
        };
        print('Uploading to Firestore:');
        print(payslipData);
        await docRef.set(payslipData, SetOptions(merge: true));
      } else {
        // Existing Aadhaar and PAN saving logic
        await docRef.set({
          'uid': widget.userId, // Add uid
          'frontImageUrl': _frontImageUrl,
          'backImageUrl': _backImageUrl,
          'updatedAt': FieldValue.serverTimestamp(),
          ...fields,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error saving to Firestore: $e');
      setState(() {
        _errorMessage = 'Failed to save document data: $e';
      });
    }
  }

  Map<String, dynamic> _parseFields(String text) {
    print('--- OCR TEXT START ---');
    print(text);
    print('--- OCR TEXT END ---');

    final fields = <String, dynamic>{};

    if (widget.documentType == 3) {
      // Pay Period
      final payPeriodMatch = RegExp(
              r'Pay Slip for the Month of ([A-Za-z]+ \d{4})',
              caseSensitive: false)
          .firstMatch(text);
      if (payPeriodMatch != null) fields['payPeriod'] = payPeriodMatch.group(1);

      // Employee Number (Emp. No.)
      final empNoMatch =
          RegExp(r'Emp\.?\s*No\.?\s*[:\-]?\s*([A-Z0-9]+)', caseSensitive: false)
              .firstMatch(text);
      if (empNoMatch != null) fields['employeeNumber'] = empNoMatch.group(1);

      // Employee Name (Name)
      final nameMatch =
          RegExp(r'Name\s*[:\-]?\s*([A-Za-z\s]+)', caseSensitive: false)
              .firstMatch(text);
      if (nameMatch != null)
        fields['employeeName'] = nameMatch.group(1)?.trim();

      // Date of Joining (DOJ)
      final dojMatch =
          RegExp(r'DOJ\s*[:\-]?\s*(\d{2}/\d{2}/\d{4})', caseSensitive: false)
              .firstMatch(text);
      if (dojMatch != null) fields['dateOfJoining'] = dojMatch.group(1);

      // Resignation Date (Resign Date)
      final resignDateMatch =
          RegExp(r'Resign Date\s*[:\-]?\s*([\d/-]*)', caseSensitive: false)
              .firstMatch(text);
      if (resignDateMatch != null)
        fields['resignationDate'] = resignDateMatch.group(1)?.trim() ?? '';

      // Office Branch (Location)
      final officeBranchMatch =
          RegExp(r'Location\s*[:\-]?\s*([A-Za-z\s]+)', caseSensitive: false)
              .firstMatch(text);
      if (officeBranchMatch != null)
        fields['officeBranch'] = officeBranchMatch.group(1)?.trim();

      // Set verification status based on key fields
      fields['isVerified'] = fields['employeeNumber'] != null &&
          fields['payPeriod'] != null &&
          fields['employeeName'] != null;
    } else {
      // Existing Aadhaar and PAN parsing logic
      RegExp aadharRegex = RegExp(r'(\d{4}\s\d{4}\s\d{4})');
      if (aadharRegex.hasMatch(text)) {
        fields['AadhaarNumber'] =
            aadharRegex.firstMatch(text)?.group(1)?.replaceAll(' ', '') ?? '';
      }

      RegExp panRegex = RegExp(r'[A-Z]{5}[0-9]{4}[A-Z]{1}');
      if (panRegex.hasMatch(text)) {
        fields['PANNumber'] = panRegex.firstMatch(text)?.group(0) ?? '';
      }
    }

    return fields;
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
            Text(
              _documentTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Subtitle
            Text(
              _isPayslip
                  ? 'Take a photo of your payslip for ${_getPayslipMonthText()}'
                  : (_isFrontCaptured && _requiresBackSide
                      ? _backSideText
                      : _frontSideText),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Image Preview
            if (_isPayslip) ...[
              // Payslip Month Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(_getPayslipMonthTextForIndex(index)),
                      selected: _currentPayslipMonth == index,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _currentPayslipMonth = index;
                            _frontImageUrl = null;
                            _frontImageFile = null;
                            _isFrontCaptured = false;
                          });
                          _loadExistingImages();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Front Image Preview
                Expanded(
                  child: GestureDetector(
                    onTap: _isUploading
                        ? null
                        : () => _showImageSourceBottomSheet(true),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: _isUploading && _frontImageFile != null
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 8),
                                  Text(
                                    'Uploading...',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : _frontImageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    _frontImageUrl!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 180,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: Colors.grey.shade400,
                                        size: 48,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _isPayslip
                                            ? '${_getPayslipMonthText()}\n(Tap to upload)'
                                            : 'Front Side\n(Tap to upload)',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                    ),
                  ),
                ),
                if (_requiresBackSide) ...[
                  const SizedBox(width: 16),
                  // Back Image Preview
                  Expanded(
                    child: GestureDetector(
                      onTap: _isUploading
                          ? null
                          : () => _showImageSourceBottomSheet(false),
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: _isUploading && _backImageFile != null
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 8),
                                    Text(
                                      'Uploading...',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : _backImageUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      _backImageUrl!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 180,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                    ),
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: Colors.grey.shade400,
                                          size: 48,
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Back Side\n(Tap to upload)',
                                          textAlign: TextAlign.center,
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
                  ),
                ],
              ],
            ),
            const SizedBox(height: 32),
            // Large round button
            GestureDetector(
              onTap: (_isProcessing || _isUploading)
                  ? null
                  : () => _showImageSourceBottomSheet(!_isFrontCaptured),
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
            // Confidentiality note
            const Text(
              "Your ID is confidential, it's only used for verification processes.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
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

  String _getPayslipMonthTextForIndex(int index) {
    final now = DateTime.now();
    final month = now.month - index;
    final year = now.year - (month <= 0 ? 1 : 0);
    final adjustedMonth = month <= 0 ? month + 12 : month;
    return '${_getMonthName(adjustedMonth)} $year';
  }
}
