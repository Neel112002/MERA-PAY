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

import 'index.dart'; // Imports other custom widgets

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:file_picker/file_picker.dart';

class ScanOCR extends StatefulWidget {
  const ScanOCR({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ScanOCR> createState() => _ScanOCRState();
}

class _ScanOCRState extends State<ScanOCR> {
  File? _imageFile;
  String? _ocrText;
  Map<String, String> _parsedData = {};
  bool _isProcessing = false;
  String? _errorMessage;

  Future<void> _showImageSourceDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _captureImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text('Upload File'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _captureImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _errorMessage = null;
        });
        await _performOCR(_imageFile!);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to capture image: $e';
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _errorMessage = null;
        });
        await _performOCR(_imageFile!);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to pick image: $e';
      });
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.first.path!);
        setState(() {
          _imageFile = file;
          _errorMessage = null;
        });
        await _performOCR(_imageFile!);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to pick file: $e';
      });
    }
  }

  Future<void> _performOCR(File imageFile) async {
    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    try {
      final inputImage = InputImage.fromFile(imageFile);
      final textRecognizer = TextRecognizer();
      final recognizedText = await textRecognizer.processImage(inputImage);
      await textRecognizer.close();

      setState(() {
        _ocrText = recognizedText.text;
        _parsedData = _parseFields(_ocrText ?? '');
        // Set Aadhaar number in app state if found
        if (_parsedData['AadhaarNumber'] != null &&
            _parsedData['AadhaarNumber']!.isNotEmpty) {
          FFAppState().aadharNumber = _parsedData['AadhaarNumber']!;
        }
      });

      print("🔍 OCR TEXT:");
      print(_ocrText);
      print("✅ Parsed JSON:");
      print(_parsedData);
    } catch (e) {
      setState(() {
        _errorMessage = 'OCR processing failed: $e';
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Map<String, String> _parseFields(String text) {
    final Map<String, String> data = {};

    RegExp nameRegex = RegExp(
        r'(?:Name|Sanjana Verma Singh)[\s:]*([A-Z][a-z]+(?: [A-Z][a-z]+)*)');
    RegExp dobRegex =
        RegExp(r'(?:DOB|DOB[\s:\/]*)?(\d{2}[\/-]\d{2}[\/-]\d{4})');
    RegExp genderRegex = RegExp(r'(?:Sex|Gender|लिंग)[\s:]*([A-Za-z]+)');
    RegExp aadharRegex = RegExp(r'(\d{4}\s\d{4}\s\d{4})');
    RegExp addressRegex =
        RegExp(r'Address[\s:]*([\s\S]+?),\s*Bihar', caseSensitive: false);

    if (nameRegex.hasMatch(text)) {
      data['Name'] = nameRegex.firstMatch(text)?.group(1) ?? '';
    }

    if (dobRegex.hasMatch(text)) {
      data['DOB'] = dobRegex.firstMatch(text)?.group(1) ?? '';
    }

    if (genderRegex.hasMatch(text)) {
      data['Gender'] = genderRegex.firstMatch(text)?.group(1) ?? '';
    }

    if (aadharRegex.hasMatch(text)) {
      data['AadhaarNumber'] = aadharRegex.firstMatch(text)?.group(1) ?? '';
    }

    if (addressRegex.hasMatch(text)) {
      data['Address'] = addressRegex.firstMatch(text)?.group(1)?.trim() ?? '';
    }

    return data;
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
              'Aadhaar Card Verification',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Subtitle
            const Text(
              'Take a photo of your Aadhaar card or choose from your gallery.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Image Preview
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: _imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 180,
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.grey.shade400,
                        size: 64,
                      ),
                    ),
            ),
            const SizedBox(height: 32),
            // Large round button
            GestureDetector(
              onTap: _isProcessing ? null : _showImageSourceDialog,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: _isProcessing ? Colors.grey.shade300 : Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: _isProcessing
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
            // OCR result
            if (FFAppState().aadharNumber.isNotEmpty && !_isProcessing)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
