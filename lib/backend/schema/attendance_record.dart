import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AttendanceRecord extends FirestoreRecord {
  AttendanceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "checkIn" field.
  DateTime? _checkIn;
  DateTime? get checkIn => _checkIn;
  bool hasCheckIn() => _checkIn != null;

  // "checkOut" field.
  DateTime? _checkOut;
  DateTime? get checkOut => _checkOut;
  bool hasCheckOut() => _checkOut != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _checkIn = snapshotData['checkIn'] as DateTime?;
    _checkOut = snapshotData['checkOut'] as DateTime?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('attendance');

  static Stream<AttendanceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AttendanceRecord.fromSnapshot(s));

  static Future<AttendanceRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AttendanceRecord.fromSnapshot(s));

  static AttendanceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AttendanceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AttendanceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AttendanceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AttendanceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AttendanceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAttendanceRecordData({
  String? userId,
  DateTime? date,
  DateTime? checkIn,
  DateTime? checkOut,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'date': date,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class AttendanceRecordDocumentEquality implements Equality<AttendanceRecord> {
  const AttendanceRecordDocumentEquality();

  @override
  bool equals(AttendanceRecord? e1, AttendanceRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.date == e2?.date &&
        e1?.checkIn == e2?.checkIn &&
        e1?.checkOut == e2?.checkOut &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(AttendanceRecord? e) => const ListEquality()
      .hash([e?.userId, e?.date, e?.checkIn, e?.checkOut, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is AttendanceRecord;
}
