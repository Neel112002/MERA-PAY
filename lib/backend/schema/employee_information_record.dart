import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EmployeeInformationRecord extends FirestoreRecord {
  EmployeeInformationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

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

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  void _initializeFields() {
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
    _uid = snapshotData['uid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('EmployeeInformation');

  static Stream<EmployeeInformationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EmployeeInformationRecord.fromSnapshot(s));

  static Future<EmployeeInformationRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => EmployeeInformationRecord.fromSnapshot(s));

  static EmployeeInformationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EmployeeInformationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EmployeeInformationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EmployeeInformationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EmployeeInformationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EmployeeInformationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEmployeeInformationRecordData({
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
  String? uid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
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
      'uid': uid,
    }.withoutNulls,
  );

  return firestoreData;
}

class EmployeeInformationRecordDocumentEquality
    implements Equality<EmployeeInformationRecord> {
  const EmployeeInformationRecordDocumentEquality();

  @override
  bool equals(EmployeeInformationRecord? e1, EmployeeInformationRecord? e2) {
    return e1?.organization == e2?.organization &&
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
        e1?.wizardStep1 == e2?.wizardStep1 &&
        e1?.uid == e2?.uid;
  }

  @override
  int hash(EmployeeInformationRecord? e) => const ListEquality().hash([
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
        e?.wizardStep1,
        e?.uid
      ]);

  @override
  bool isValidKey(Object? o) => o is EmployeeInformationRecord;
}
