import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VerificationsRecord extends FirestoreRecord {
  VerificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "aadhaarVerified" field.
  bool? _aadhaarVerified;
  bool get aadhaarVerified => _aadhaarVerified ?? false;
  bool hasAadhaarVerified() => _aadhaarVerified != null;

  // "aadhaarNumber" field.
  String? _aadhaarNumber;
  String get aadhaarNumber => _aadhaarNumber ?? '';
  bool hasAadhaarNumber() => _aadhaarNumber != null;

  // "aadhaarFrontUrl" field.
  String? _aadhaarFrontUrl;
  String get aadhaarFrontUrl => _aadhaarFrontUrl ?? '';
  bool hasAadhaarFrontUrl() => _aadhaarFrontUrl != null;

  // "aadhaarBackUrl" field.
  String? _aadhaarBackUrl;
  String get aadhaarBackUrl => _aadhaarBackUrl ?? '';
  bool hasAadhaarBackUrl() => _aadhaarBackUrl != null;

  // "panVerified" field.
  bool? _panVerified;
  bool get panVerified => _panVerified ?? false;
  bool hasPanVerified() => _panVerified != null;

  // "panNumber" field.
  String? _panNumber;
  String get panNumber => _panNumber ?? '';
  bool hasPanNumber() => _panNumber != null;

  // "panFrontUrl" field.
  String? _panFrontUrl;
  String get panFrontUrl => _panFrontUrl ?? '';
  bool hasPanFrontUrl() => _panFrontUrl != null;

  // "panBackUrl" field.
  String? _panBackUrl;
  String get panBackUrl => _panBackUrl ?? '';
  bool hasPanBackUrl() => _panBackUrl != null;

  // "payslipVerified" field.
  bool? _payslipVerified;
  bool get payslipVerified => _payslipVerified ?? false;
  bool hasPayslipVerified() => _payslipVerified != null;

  // "payslipPayPeriod" field.
  String? _payslipPayPeriod;
  String get payslipPayPeriod => _payslipPayPeriod ?? '';
  bool hasPayslipPayPeriod() => _payslipPayPeriod != null;

  // "payslipEmployeeNumber" field.
  String? _payslipEmployeeNumber;
  String get payslipEmployeeNumber => _payslipEmployeeNumber ?? '';
  bool hasPayslipEmployeeNumber() => _payslipEmployeeNumber != null;

  // "payslipEmployeeName" field.
  String? _payslipEmployeeName;
  String get payslipEmployeeName => _payslipEmployeeName ?? '';
  bool hasPayslipEmployeeName() => _payslipEmployeeName != null;

  // "payslipDateOfJoining" field.
  String? _payslipDateOfJoining;
  String get payslipDateOfJoining => _payslipDateOfJoining ?? '';
  bool hasPayslipDateOfJoining() => _payslipDateOfJoining != null;

  // "payslipOfficeBranch" field.
  String? _payslipOfficeBranch;
  String get payslipOfficeBranch => _payslipOfficeBranch ?? '';
  bool hasPayslipOfficeBranch() => _payslipOfficeBranch != null;

  // "payslipImageUrl" field.
  String? _payslipImageUrl;
  String get payslipImageUrl => _payslipImageUrl ?? '';
  bool hasPayslipImageUrl() => _payslipImageUrl != null;

  // "payslipPayDate" field.
  String? _payslipPayDate;
  String get payslipPayDate => _payslipPayDate ?? '';
  bool hasPayslipPayDate() => _payslipPayDate != null;

  // "payslipNetSalary" field.
  String? _payslipNetSalary;
  String get payslipNetSalary => _payslipNetSalary ?? '';
  bool hasPayslipNetSalary() => _payslipNetSalary != null;

  // "selfieVerified" field.
  bool? _selfieVerified;
  bool get selfieVerified => _selfieVerified ?? false;
  bool hasSelfieVerified() => _selfieVerified != null;

  // "selfieImageUrl" field.
  String? _selfieImageUrl;
  String get selfieImageUrl => _selfieImageUrl ?? '';
  bool hasSelfieImageUrl() => _selfieImageUrl != null;

  // "allVerified" field.
  bool? _allVerified;
  bool get allVerified => _allVerified ?? false;
  bool hasAllVerified() => _allVerified != null;

  // "wizardstep2" field.
  bool? _wizardstep2;
  bool get wizardstep2 => _wizardstep2 ?? false;
  bool hasWizardstep2() => _wizardstep2 != null;

  // "Organization" field.
  String? _organization;
  String get organization => _organization ?? '';
  bool hasOrganization() => _organization != null;

  // "AnnualIncome" field.
  String? _annualIncome;
  String get annualIncome => _annualIncome ?? '';
  bool hasAnnualIncome() => _annualIncome != null;

  // "FirstName" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  bool hasFirstName() => _firstName != null;

  // "MiddleName" field.
  String? _middleName;
  String get middleName => _middleName ?? '';
  bool hasMiddleName() => _middleName != null;

  // "LastName" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  bool hasLastName() => _lastName != null;

  // "DateofBirth" field.
  String? _dateofBirth;
  String get dateofBirth => _dateofBirth ?? '';
  bool hasDateofBirth() => _dateofBirth != null;

  // "Gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "City" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "PostalCode" field.
  String? _postalCode;
  String get postalCode => _postalCode ?? '';
  bool hasPostalCode() => _postalCode != null;

  // "StreetAddress" field.
  String? _streetAddress;
  String get streetAddress => _streetAddress ?? '';
  bool hasStreetAddress() => _streetAddress != null;

  // "FathersName" field.
  String? _fathersName;
  String get fathersName => _fathersName ?? '';
  bool hasFathersName() => _fathersName != null;

  // "MothersName" field.
  String? _mothersName;
  String get mothersName => _mothersName ?? '';
  bool hasMothersName() => _mothersName != null;

  // "CompanyName" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  // "WizardStep1" field.
  bool? _wizardStep1;
  bool get wizardStep1 => _wizardStep1 ?? false;
  bool hasWizardStep1() => _wizardStep1 != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
    _aadhaarVerified = snapshotData['aadhaarVerified'] as bool?;
    _aadhaarNumber = snapshotData['aadhaarNumber'] as String?;
    _aadhaarFrontUrl = snapshotData['aadhaarFrontUrl'] as String?;
    _aadhaarBackUrl = snapshotData['aadhaarBackUrl'] as String?;
    _panVerified = snapshotData['panVerified'] as bool?;
    _panNumber = snapshotData['panNumber'] as String?;
    _panFrontUrl = snapshotData['panFrontUrl'] as String?;
    _panBackUrl = snapshotData['panBackUrl'] as String?;
    _payslipVerified = snapshotData['payslipVerified'] as bool?;
    _payslipPayPeriod = snapshotData['payslipPayPeriod'] as String?;
    _payslipEmployeeNumber = snapshotData['payslipEmployeeNumber'] as String?;
    _payslipEmployeeName = snapshotData['payslipEmployeeName'] as String?;
    _payslipDateOfJoining = snapshotData['payslipDateOfJoining'] as String?;
    _payslipOfficeBranch = snapshotData['payslipOfficeBranch'] as String?;
    _payslipImageUrl = snapshotData['payslipImageUrl'] as String?;
    _payslipPayDate = snapshotData['payslipPayDate'] as String?;
    _payslipNetSalary = snapshotData['payslipNetSalary'] as String?;
    _selfieVerified = snapshotData['selfieVerified'] as bool?;
    _selfieImageUrl = snapshotData['selfieImageUrl'] as String?;
    _allVerified = snapshotData['allVerified'] as bool?;
    _wizardstep2 = snapshotData['wizardstep2'] as bool?;
    _organization = snapshotData['Organization'] as String?;
    _annualIncome = snapshotData['AnnualIncome'] as String?;
    _firstName = snapshotData['FirstName'] as String?;
    _middleName = snapshotData['MiddleName'] as String?;
    _lastName = snapshotData['LastName'] as String?;
    _dateofBirth = snapshotData['DateofBirth'] as String?;
    _gender = snapshotData['Gender'] as String?;
    _city = snapshotData['City'] as String?;
    _postalCode = snapshotData['PostalCode'] as String?;
    _streetAddress = snapshotData['StreetAddress'] as String?;
    _fathersName = snapshotData['FathersName'] as String?;
    _mothersName = snapshotData['MothersName'] as String?;
    _companyName = snapshotData['CompanyName'] as String?;
    _wizardStep1 = snapshotData['WizardStep1'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('verifications');

  static Stream<VerificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VerificationsRecord.fromSnapshot(s));

  static Future<VerificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VerificationsRecord.fromSnapshot(s));

  static VerificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      VerificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VerificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VerificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VerificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VerificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVerificationsRecordData({
  String? uid,
  DateTime? updatedAt,
  bool? aadhaarVerified,
  String? aadhaarNumber,
  String? aadhaarFrontUrl,
  String? aadhaarBackUrl,
  bool? panVerified,
  String? panNumber,
  String? panFrontUrl,
  String? panBackUrl,
  bool? payslipVerified,
  String? payslipPayPeriod,
  String? payslipEmployeeNumber,
  String? payslipEmployeeName,
  String? payslipDateOfJoining,
  String? payslipOfficeBranch,
  String? payslipImageUrl,
  String? payslipPayDate,
  String? payslipNetSalary,
  bool? selfieVerified,
  String? selfieImageUrl,
  bool? allVerified,
  bool? wizardstep2,
  String? organization,
  String? annualIncome,
  String? firstName,
  String? middleName,
  String? lastName,
  String? dateofBirth,
  String? gender,
  String? city,
  String? postalCode,
  String? streetAddress,
  String? fathersName,
  String? mothersName,
  String? companyName,
  bool? wizardStep1,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'updatedAt': updatedAt,
      'aadhaarVerified': aadhaarVerified,
      'aadhaarNumber': aadhaarNumber,
      'aadhaarFrontUrl': aadhaarFrontUrl,
      'aadhaarBackUrl': aadhaarBackUrl,
      'panVerified': panVerified,
      'panNumber': panNumber,
      'panFrontUrl': panFrontUrl,
      'panBackUrl': panBackUrl,
      'payslipVerified': payslipVerified,
      'payslipPayPeriod': payslipPayPeriod,
      'payslipEmployeeNumber': payslipEmployeeNumber,
      'payslipEmployeeName': payslipEmployeeName,
      'payslipDateOfJoining': payslipDateOfJoining,
      'payslipOfficeBranch': payslipOfficeBranch,
      'payslipImageUrl': payslipImageUrl,
      'payslipPayDate': payslipPayDate,
      'payslipNetSalary': payslipNetSalary,
      'selfieVerified': selfieVerified,
      'selfieImageUrl': selfieImageUrl,
      'allVerified': allVerified,
      'wizardstep2': wizardstep2,
      'Organization': organization,
      'AnnualIncome': annualIncome,
      'FirstName': firstName,
      'MiddleName': middleName,
      'LastName': lastName,
      'DateofBirth': dateofBirth,
      'Gender': gender,
      'City': city,
      'PostalCode': postalCode,
      'StreetAddress': streetAddress,
      'FathersName': fathersName,
      'MothersName': mothersName,
      'CompanyName': companyName,
      'WizardStep1': wizardStep1,
    }.withoutNulls,
  );

  return firestoreData;
}

class VerificationsRecordDocumentEquality
    implements Equality<VerificationsRecord> {
  const VerificationsRecordDocumentEquality();

  @override
  bool equals(VerificationsRecord? e1, VerificationsRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.aadhaarVerified == e2?.aadhaarVerified &&
        e1?.aadhaarNumber == e2?.aadhaarNumber &&
        e1?.aadhaarFrontUrl == e2?.aadhaarFrontUrl &&
        e1?.aadhaarBackUrl == e2?.aadhaarBackUrl &&
        e1?.panVerified == e2?.panVerified &&
        e1?.panNumber == e2?.panNumber &&
        e1?.panFrontUrl == e2?.panFrontUrl &&
        e1?.panBackUrl == e2?.panBackUrl &&
        e1?.payslipVerified == e2?.payslipVerified &&
        e1?.payslipPayPeriod == e2?.payslipPayPeriod &&
        e1?.payslipEmployeeNumber == e2?.payslipEmployeeNumber &&
        e1?.payslipEmployeeName == e2?.payslipEmployeeName &&
        e1?.payslipDateOfJoining == e2?.payslipDateOfJoining &&
        e1?.payslipOfficeBranch == e2?.payslipOfficeBranch &&
        e1?.payslipImageUrl == e2?.payslipImageUrl &&
        e1?.payslipPayDate == e2?.payslipPayDate &&
        e1?.payslipNetSalary == e2?.payslipNetSalary &&
        e1?.selfieVerified == e2?.selfieVerified &&
        e1?.selfieImageUrl == e2?.selfieImageUrl &&
        e1?.allVerified == e2?.allVerified &&
        e1?.wizardstep2 == e2?.wizardstep2 &&
        e1?.organization == e2?.organization &&
        e1?.annualIncome == e2?.annualIncome &&
        e1?.firstName == e2?.firstName &&
        e1?.middleName == e2?.middleName &&
        e1?.lastName == e2?.lastName &&
        e1?.dateofBirth == e2?.dateofBirth &&
        e1?.gender == e2?.gender &&
        e1?.city == e2?.city &&
        e1?.postalCode == e2?.postalCode &&
        e1?.streetAddress == e2?.streetAddress &&
        e1?.fathersName == e2?.fathersName &&
        e1?.mothersName == e2?.mothersName &&
        e1?.companyName == e2?.companyName &&
        e1?.wizardStep1 == e2?.wizardStep1;
  }

  @override
  int hash(VerificationsRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.updatedAt,
        e?.aadhaarVerified,
        e?.aadhaarNumber,
        e?.aadhaarFrontUrl,
        e?.aadhaarBackUrl,
        e?.panVerified,
        e?.panNumber,
        e?.panFrontUrl,
        e?.panBackUrl,
        e?.payslipVerified,
        e?.payslipPayPeriod,
        e?.payslipEmployeeNumber,
        e?.payslipEmployeeName,
        e?.payslipDateOfJoining,
        e?.payslipOfficeBranch,
        e?.payslipImageUrl,
        e?.payslipPayDate,
        e?.payslipNetSalary,
        e?.selfieVerified,
        e?.selfieImageUrl,
        e?.allVerified,
        e?.wizardstep2,
        e?.organization,
        e?.annualIncome,
        e?.firstName,
        e?.middleName,
        e?.lastName,
        e?.dateofBirth,
        e?.gender,
        e?.city,
        e?.postalCode,
        e?.streetAddress,
        e?.fathersName,
        e?.mothersName,
        e?.companyName,
        e?.wizardStep1
      ]);

  @override
  bool isValidKey(Object? o) => o is VerificationsRecord;
}
