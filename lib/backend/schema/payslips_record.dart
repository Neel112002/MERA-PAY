import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PayslipsRecord extends FirestoreRecord {
  PayslipsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "month1ImageUrl" field.
  String? _month1ImageUrl;
  String get month1ImageUrl => _month1ImageUrl ?? '';
  bool hasMonth1ImageUrl() => _month1ImageUrl != null;

  // "month1PayPeriod" field.
  String? _month1PayPeriod;
  String get month1PayPeriod => _month1PayPeriod ?? '';
  bool hasMonth1PayPeriod() => _month1PayPeriod != null;

  // "month1EmployeeNumber" field.
  String? _month1EmployeeNumber;
  String get month1EmployeeNumber => _month1EmployeeNumber ?? '';
  bool hasMonth1EmployeeNumber() => _month1EmployeeNumber != null;

  // "month1EmployeeName" field.
  String? _month1EmployeeName;
  String get month1EmployeeName => _month1EmployeeName ?? '';
  bool hasMonth1EmployeeName() => _month1EmployeeName != null;

  // "month1DateOfJoining" field.
  String? _month1DateOfJoining;
  String get month1DateOfJoining => _month1DateOfJoining ?? '';
  bool hasMonth1DateOfJoining() => _month1DateOfJoining != null;

  // "month1ResignationDate" field.
  String? _month1ResignationDate;
  String get month1ResignationDate => _month1ResignationDate ?? '';
  bool hasMonth1ResignationDate() => _month1ResignationDate != null;

  // "month1OfficeBranch" field.
  String? _month1OfficeBranch;
  String get month1OfficeBranch => _month1OfficeBranch ?? '';
  bool hasMonth1OfficeBranch() => _month1OfficeBranch != null;

  // "month1IsVerified" field.
  bool? _month1IsVerified;
  bool get month1IsVerified => _month1IsVerified ?? false;
  bool hasMonth1IsVerified() => _month1IsVerified != null;

  // "month1UpdatedAt" field.
  DateTime? _month1UpdatedAt;
  DateTime? get month1UpdatedAt => _month1UpdatedAt;
  bool hasMonth1UpdatedAt() => _month1UpdatedAt != null;

  // "month2ImageUrl" field.
  String? _month2ImageUrl;
  String get month2ImageUrl => _month2ImageUrl ?? '';
  bool hasMonth2ImageUrl() => _month2ImageUrl != null;

  // "month2PayPeriod" field.
  String? _month2PayPeriod;
  String get month2PayPeriod => _month2PayPeriod ?? '';
  bool hasMonth2PayPeriod() => _month2PayPeriod != null;

  // "month2EmployeeNumber" field.
  String? _month2EmployeeNumber;
  String get month2EmployeeNumber => _month2EmployeeNumber ?? '';
  bool hasMonth2EmployeeNumber() => _month2EmployeeNumber != null;

  // "month2EmployeeName" field.
  String? _month2EmployeeName;
  String get month2EmployeeName => _month2EmployeeName ?? '';
  bool hasMonth2EmployeeName() => _month2EmployeeName != null;

  // "month2DateOfJoining" field.
  String? _month2DateOfJoining;
  String get month2DateOfJoining => _month2DateOfJoining ?? '';
  bool hasMonth2DateOfJoining() => _month2DateOfJoining != null;

  // "month2ResignationDate" field.
  String? _month2ResignationDate;
  String get month2ResignationDate => _month2ResignationDate ?? '';
  bool hasMonth2ResignationDate() => _month2ResignationDate != null;

  // "month2OfficeBranch" field.
  String? _month2OfficeBranch;
  String get month2OfficeBranch => _month2OfficeBranch ?? '';
  bool hasMonth2OfficeBranch() => _month2OfficeBranch != null;

  // "month2IsVerified" field.
  bool? _month2IsVerified;
  bool get month2IsVerified => _month2IsVerified ?? false;
  bool hasMonth2IsVerified() => _month2IsVerified != null;

  // "month2UpdatedAt" field.
  DateTime? _month2UpdatedAt;
  DateTime? get month2UpdatedAt => _month2UpdatedAt;
  bool hasMonth2UpdatedAt() => _month2UpdatedAt != null;

  // "month3ImageUrl" field.
  String? _month3ImageUrl;
  String get month3ImageUrl => _month3ImageUrl ?? '';
  bool hasMonth3ImageUrl() => _month3ImageUrl != null;

  // "month3PayPeriod" field.
  String? _month3PayPeriod;
  String get month3PayPeriod => _month3PayPeriod ?? '';
  bool hasMonth3PayPeriod() => _month3PayPeriod != null;

  // "month3EmployeeNumber" field.
  String? _month3EmployeeNumber;
  String get month3EmployeeNumber => _month3EmployeeNumber ?? '';
  bool hasMonth3EmployeeNumber() => _month3EmployeeNumber != null;

  // "month3EmployeeName" field.
  String? _month3EmployeeName;
  String get month3EmployeeName => _month3EmployeeName ?? '';
  bool hasMonth3EmployeeName() => _month3EmployeeName != null;

  // "month3DateOfJoining" field.
  String? _month3DateOfJoining;
  String get month3DateOfJoining => _month3DateOfJoining ?? '';
  bool hasMonth3DateOfJoining() => _month3DateOfJoining != null;

  // "month3ResignationDate" field.
  String? _month3ResignationDate;
  String get month3ResignationDate => _month3ResignationDate ?? '';
  bool hasMonth3ResignationDate() => _month3ResignationDate != null;

  // "month3OfficeBranch" field.
  String? _month3OfficeBranch;
  String get month3OfficeBranch => _month3OfficeBranch ?? '';
  bool hasMonth3OfficeBranch() => _month3OfficeBranch != null;

  // "month3IsVerified" field.
  bool? _month3IsVerified;
  bool get month3IsVerified => _month3IsVerified ?? false;
  bool hasMonth3IsVerified() => _month3IsVerified != null;

  // "month3UpdatedAt" field.
  DateTime? _month3UpdatedAt;
  DateTime? get month3UpdatedAt => _month3UpdatedAt;
  bool hasMonth3UpdatedAt() => _month3UpdatedAt != null;

  // "Paydate1" field.
  DateTime? _paydate1;
  DateTime? get paydate1 => _paydate1;
  bool hasPaydate1() => _paydate1 != null;

  // "NetSalary" field.
  String? _netSalary;
  String get netSalary => _netSalary ?? '';
  bool hasNetSalary() => _netSalary != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  void _initializeFields() {
    _month1ImageUrl = snapshotData['month1ImageUrl'] as String?;
    _month1PayPeriod = snapshotData['month1PayPeriod'] as String?;
    _month1EmployeeNumber = snapshotData['month1EmployeeNumber'] as String?;
    _month1EmployeeName = snapshotData['month1EmployeeName'] as String?;
    _month1DateOfJoining = snapshotData['month1DateOfJoining'] as String?;
    _month1ResignationDate = snapshotData['month1ResignationDate'] as String?;
    _month1OfficeBranch = snapshotData['month1OfficeBranch'] as String?;
    _month1IsVerified = snapshotData['month1IsVerified'] as bool?;
    _month1UpdatedAt = snapshotData['month1UpdatedAt'] as DateTime?;
    _month2ImageUrl = snapshotData['month2ImageUrl'] as String?;
    _month2PayPeriod = snapshotData['month2PayPeriod'] as String?;
    _month2EmployeeNumber = snapshotData['month2EmployeeNumber'] as String?;
    _month2EmployeeName = snapshotData['month2EmployeeName'] as String?;
    _month2DateOfJoining = snapshotData['month2DateOfJoining'] as String?;
    _month2ResignationDate = snapshotData['month2ResignationDate'] as String?;
    _month2OfficeBranch = snapshotData['month2OfficeBranch'] as String?;
    _month2IsVerified = snapshotData['month2IsVerified'] as bool?;
    _month2UpdatedAt = snapshotData['month2UpdatedAt'] as DateTime?;
    _month3ImageUrl = snapshotData['month3ImageUrl'] as String?;
    _month3PayPeriod = snapshotData['month3PayPeriod'] as String?;
    _month3EmployeeNumber = snapshotData['month3EmployeeNumber'] as String?;
    _month3EmployeeName = snapshotData['month3EmployeeName'] as String?;
    _month3DateOfJoining = snapshotData['month3DateOfJoining'] as String?;
    _month3ResignationDate = snapshotData['month3ResignationDate'] as String?;
    _month3OfficeBranch = snapshotData['month3OfficeBranch'] as String?;
    _month3IsVerified = snapshotData['month3IsVerified'] as bool?;
    _month3UpdatedAt = snapshotData['month3UpdatedAt'] as DateTime?;
    _paydate1 = snapshotData['Paydate1'] as DateTime?;
    _netSalary = snapshotData['NetSalary'] as String?;
    _uid = snapshotData['uid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('payslips');

  static Stream<PayslipsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PayslipsRecord.fromSnapshot(s));

  static Future<PayslipsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PayslipsRecord.fromSnapshot(s));

  static PayslipsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PayslipsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PayslipsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PayslipsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PayslipsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PayslipsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPayslipsRecordData({
  String? month1ImageUrl,
  String? month1PayPeriod,
  String? month1EmployeeNumber,
  String? month1EmployeeName,
  String? month1DateOfJoining,
  String? month1ResignationDate,
  String? month1OfficeBranch,
  bool? month1IsVerified,
  DateTime? month1UpdatedAt,
  String? month2ImageUrl,
  String? month2PayPeriod,
  String? month2EmployeeNumber,
  String? month2EmployeeName,
  String? month2DateOfJoining,
  String? month2ResignationDate,
  String? month2OfficeBranch,
  bool? month2IsVerified,
  DateTime? month2UpdatedAt,
  String? month3ImageUrl,
  String? month3PayPeriod,
  String? month3EmployeeNumber,
  String? month3EmployeeName,
  String? month3DateOfJoining,
  String? month3ResignationDate,
  String? month3OfficeBranch,
  bool? month3IsVerified,
  DateTime? month3UpdatedAt,
  DateTime? paydate1,
  String? netSalary,
  String? uid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'month1ImageUrl': month1ImageUrl,
      'month1PayPeriod': month1PayPeriod,
      'month1EmployeeNumber': month1EmployeeNumber,
      'month1EmployeeName': month1EmployeeName,
      'month1DateOfJoining': month1DateOfJoining,
      'month1ResignationDate': month1ResignationDate,
      'month1OfficeBranch': month1OfficeBranch,
      'month1IsVerified': month1IsVerified,
      'month1UpdatedAt': month1UpdatedAt,
      'month2ImageUrl': month2ImageUrl,
      'month2PayPeriod': month2PayPeriod,
      'month2EmployeeNumber': month2EmployeeNumber,
      'month2EmployeeName': month2EmployeeName,
      'month2DateOfJoining': month2DateOfJoining,
      'month2ResignationDate': month2ResignationDate,
      'month2OfficeBranch': month2OfficeBranch,
      'month2IsVerified': month2IsVerified,
      'month2UpdatedAt': month2UpdatedAt,
      'month3ImageUrl': month3ImageUrl,
      'month3PayPeriod': month3PayPeriod,
      'month3EmployeeNumber': month3EmployeeNumber,
      'month3EmployeeName': month3EmployeeName,
      'month3DateOfJoining': month3DateOfJoining,
      'month3ResignationDate': month3ResignationDate,
      'month3OfficeBranch': month3OfficeBranch,
      'month3IsVerified': month3IsVerified,
      'month3UpdatedAt': month3UpdatedAt,
      'Paydate1': paydate1,
      'NetSalary': netSalary,
      'uid': uid,
    }.withoutNulls,
  );

  return firestoreData;
}

class PayslipsRecordDocumentEquality implements Equality<PayslipsRecord> {
  const PayslipsRecordDocumentEquality();

  @override
  bool equals(PayslipsRecord? e1, PayslipsRecord? e2) {
    return e1?.month1ImageUrl == e2?.month1ImageUrl &&
        e1?.month1PayPeriod == e2?.month1PayPeriod &&
        e1?.month1EmployeeNumber == e2?.month1EmployeeNumber &&
        e1?.month1EmployeeName == e2?.month1EmployeeName &&
        e1?.month1DateOfJoining == e2?.month1DateOfJoining &&
        e1?.month1ResignationDate == e2?.month1ResignationDate &&
        e1?.month1OfficeBranch == e2?.month1OfficeBranch &&
        e1?.month1IsVerified == e2?.month1IsVerified &&
        e1?.month1UpdatedAt == e2?.month1UpdatedAt &&
        e1?.month2ImageUrl == e2?.month2ImageUrl &&
        e1?.month2PayPeriod == e2?.month2PayPeriod &&
        e1?.month2EmployeeNumber == e2?.month2EmployeeNumber &&
        e1?.month2EmployeeName == e2?.month2EmployeeName &&
        e1?.month2DateOfJoining == e2?.month2DateOfJoining &&
        e1?.month2ResignationDate == e2?.month2ResignationDate &&
        e1?.month2OfficeBranch == e2?.month2OfficeBranch &&
        e1?.month2IsVerified == e2?.month2IsVerified &&
        e1?.month2UpdatedAt == e2?.month2UpdatedAt &&
        e1?.month3ImageUrl == e2?.month3ImageUrl &&
        e1?.month3PayPeriod == e2?.month3PayPeriod &&
        e1?.month3EmployeeNumber == e2?.month3EmployeeNumber &&
        e1?.month3EmployeeName == e2?.month3EmployeeName &&
        e1?.month3DateOfJoining == e2?.month3DateOfJoining &&
        e1?.month3ResignationDate == e2?.month3ResignationDate &&
        e1?.month3OfficeBranch == e2?.month3OfficeBranch &&
        e1?.month3IsVerified == e2?.month3IsVerified &&
        e1?.month3UpdatedAt == e2?.month3UpdatedAt &&
        e1?.paydate1 == e2?.paydate1 &&
        e1?.netSalary == e2?.netSalary &&
        e1?.uid == e2?.uid;
  }

  @override
  int hash(PayslipsRecord? e) => const ListEquality().hash([
        e?.month1ImageUrl,
        e?.month1PayPeriod,
        e?.month1EmployeeNumber,
        e?.month1EmployeeName,
        e?.month1DateOfJoining,
        e?.month1ResignationDate,
        e?.month1OfficeBranch,
        e?.month1IsVerified,
        e?.month1UpdatedAt,
        e?.month2ImageUrl,
        e?.month2PayPeriod,
        e?.month2EmployeeNumber,
        e?.month2EmployeeName,
        e?.month2DateOfJoining,
        e?.month2ResignationDate,
        e?.month2OfficeBranch,
        e?.month2IsVerified,
        e?.month2UpdatedAt,
        e?.month3ImageUrl,
        e?.month3PayPeriod,
        e?.month3EmployeeNumber,
        e?.month3EmployeeName,
        e?.month3DateOfJoining,
        e?.month3ResignationDate,
        e?.month3OfficeBranch,
        e?.month3IsVerified,
        e?.month3UpdatedAt,
        e?.paydate1,
        e?.netSalary,
        e?.uid
      ]);

  @override
  bool isValidKey(Object? o) => o is PayslipsRecord;
}
