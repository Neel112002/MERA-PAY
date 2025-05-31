// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> aggregateVerificationData(
  String userId,
) async {
  try {
    // Get data from all collections
    final aadhaarDoc = await FirebaseFirestore.instance
        .collection('aadhaar_cards')
        .doc(userId)
        .get();

    final panDoc = await FirebaseFirestore.instance
        .collection('pan_cards')
        .doc(userId)
        .get();

    final payslipDoc = await FirebaseFirestore.instance
        .collection('payslips')
        .doc(userId)
        .get();

    final selfieDoc = await FirebaseFirestore.instance
        .collection('selfies')
        .doc(userId)
        .get();

    final employeeDoc = await FirebaseFirestore.instance
        .collection('EmployeeInformation')
        .doc(userId)
        .get();
    final Map<String, dynamic> employeeData =
        employeeDoc.exists && employeeDoc.data() != null
            ? Map<String, dynamic>.from(employeeDoc.data()!)
            : <String, dynamic>{};

    // Get document data
    final aadhaarData = aadhaarDoc.exists ? aadhaarDoc.data() : null;
    final panData = panDoc.exists ? panDoc.data() : null;
    final payslipData = payslipDoc.exists ? payslipDoc.data() : null;
    final selfieData = selfieDoc.exists ? selfieDoc.data() : null;

    // Check if all verifications are complete
    final bool allVerified = (aadhaarData?['isVerified'] ?? false) &&
        (panData?['isVerified'] ?? false) &&
        (payslipData?['month1IsVerified'] ?? false) &&
        (selfieData?['isVerified'] ?? false);

    // Create flat verification document
    final Map<String, dynamic> verificationData = {
      // EmployeeInformation fields (merged in flat)
      ...employeeData,

      'uid': userId,
      'updatedAt': FieldValue.serverTimestamp(),

      // Aadhaar fields
      'aadhaarVerified': aadhaarData?['isVerified'] ?? false,
      'aadhaarNumber': aadhaarData?['documentNumber'] ?? '',
      'aadhaarFrontUrl': aadhaarData?['frontImageUrl'] ?? '',
      'aadhaarBackUrl': aadhaarData?['backImageUrl'] ?? '',

      // PAN fields
      'panVerified': panData?['isVerified'] ?? false,
      'panNumber': panData?['documentNumber'] ?? '',
      'panFrontUrl': panData?['frontImageUrl'] ?? '',
      'panBackUrl': panData?['backImageUrl'] ?? '',

      // Payslip fields
      'payslipVerified': payslipData?['month1IsVerified'] ?? false,
      'payslipPayPeriod': payslipData?['month1PayPeriod'] ?? '',
      'payslipEmployeeNumber': payslipData?['month1EmployeeNumber'] ?? '',
      'payslipEmployeeName': payslipData?['month1EmployeeName'] ?? '',
      'payslipDateOfJoining': payslipData?['month1DateOfJoining'] ?? '',
      'payslipOfficeBranch': payslipData?['month1OfficeBranch'] ?? '',
      'payslipImageUrl': payslipData?['month1ImageUrl'] ?? '',
      'payslipPayDate': payslipData?['PayDate1'] ?? '',
      'payslipNetSalary': payslipData?['NetSalary'] ?? '',

      // Selfie fields
      'selfieVerified': selfieData?['isVerified'] ?? false,
      'selfieImageUrl': selfieData?['imageUrl'] ?? '',

      // Overall verification
      'allVerified': allVerified,
      'wizardstep2':
          allVerified, // This will be true when all verifications are complete
    };

    // Save to verifications collection
    await FirebaseFirestore.instance
        .collection('verifications')
        .doc(userId)
        .set(verificationData);

    print('Successfully updated verification status for user: $userId');
  } catch (e) {
    print('Error updating verification status: $e');
    throw Exception('Failed to update verification status: $e');
  }
}
