import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AttendanceSummariesRecord extends FirestoreRecord {
  AttendanceSummariesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "month" field.
  String? _month;
  String get month => _month ?? '';
  bool hasMonth() => _month != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  bool hasDate() => _date != null;

  // "hoursWorked" field.
  int? _hoursWorked;
  int get hoursWorked => _hoursWorked ?? 0;
  bool hasHoursWorked() => _hoursWorked != null;

  // "clockInTime" field.
  String? _clockInTime;
  String get clockInTime => _clockInTime ?? '';
  bool hasClockInTime() => _clockInTime != null;

  // "clockOutTime" field.
  String? _clockOutTime;
  String get clockOutTime => _clockOutTime ?? '';
  bool hasClockOutTime() => _clockOutTime != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "overtime" field.
  int? _overtime;
  int get overtime => _overtime ?? 0;
  bool hasOvertime() => _overtime != null;

  // "isRegular" field.
  bool? _isRegular;
  bool get isRegular => _isRegular ?? false;
  bool hasIsRegular() => _isRegular != null;

  // "lastUpdated" field.
  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _lastUpdated;
  bool hasLastUpdated() => _lastUpdated != null;

  // "totalHoursWorked" field.
  int? _totalHoursWorked;
  int get totalHoursWorked => _totalHoursWorked ?? 0;
  bool hasTotalHoursWorked() => _totalHoursWorked != null;

  // "totalDaysWorked" field.
  int? _totalDaysWorked;
  int get totalDaysWorked => _totalDaysWorked ?? 0;
  bool hasTotalDaysWorked() => _totalDaysWorked != null;

  // "regularDays" field.
  int? _regularDays;
  int get regularDays => _regularDays ?? 0;
  bool hasRegularDays() => _regularDays != null;

  // "overtimeMinutes" field.
  int? _overtimeMinutes;
  int get overtimeMinutes => _overtimeMinutes ?? 0;
  bool hasOvertimeMinutes() => _overtimeMinutes != null;

  // "totalMinutesWorked" field.
  int? _totalMinutesWorked;
  int get totalMinutesWorked => _totalMinutesWorked ?? 0;
  bool hasTotalMinutesWorked() => _totalMinutesWorked != null;

  // "minutesWorked" field.
  int? _minutesWorked;
  int get minutesWorked => _minutesWorked ?? 0;
  bool hasMinutesWorked() => _minutesWorked != null;

  // "totalWorkHours" field.
  double? _totalWorkHours;
  double get totalWorkHours => _totalWorkHours ?? 0.0;
  bool hasTotalWorkHours() => _totalWorkHours != null;

  // "regularWorkHours" field.
  double? _regularWorkHours;
  double get regularWorkHours => _regularWorkHours ?? 0.0;
  bool hasRegularWorkHours() => _regularWorkHours != null;

  // "overtimeWorkHours" field.
  double? _overtimeWorkHours;
  double get overtimeWorkHours => _overtimeWorkHours ?? 0.0;
  bool hasOvertimeWorkHours() => _overtimeWorkHours != null;

  // "firstCheckInTime" field.
  String? _firstCheckInTime;
  String get firstCheckInTime => _firstCheckInTime ?? '';
  bool hasFirstCheckInTime() => _firstCheckInTime != null;

  // "lastCheckOutTime" field.
  String? _lastCheckOutTime;
  String get lastCheckOutTime => _lastCheckOutTime ?? '';
  bool hasLastCheckOutTime() => _lastCheckOutTime != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as String?;
    _month = snapshotData['month'] as String?;
    _date = snapshotData['date'] as String?;
    _hoursWorked = castToType<int>(snapshotData['hoursWorked']);
    _clockInTime = snapshotData['clockInTime'] as String?;
    _clockOutTime = snapshotData['clockOutTime'] as String?;
    _status = snapshotData['status'] as String?;
    _overtime = castToType<int>(snapshotData['overtime']);
    _isRegular = snapshotData['isRegular'] as bool?;
    _lastUpdated = snapshotData['lastUpdated'] as DateTime?;
    _totalHoursWorked = castToType<int>(snapshotData['totalHoursWorked']);
    _totalDaysWorked = castToType<int>(snapshotData['totalDaysWorked']);
    _regularDays = castToType<int>(snapshotData['regularDays']);
    _overtimeMinutes = castToType<int>(snapshotData['overtimeMinutes']);
    _totalMinutesWorked = castToType<int>(snapshotData['totalMinutesWorked']);
    _minutesWorked = castToType<int>(snapshotData['minutesWorked']);
    _totalWorkHours = castToType<double>(snapshotData['totalWorkHours']);
    _regularWorkHours = castToType<double>(snapshotData['regularWorkHours']);
    _overtimeWorkHours = castToType<double>(snapshotData['overtimeWorkHours']);
    _firstCheckInTime = snapshotData['firstCheckInTime'] as String?;
    _lastCheckOutTime = snapshotData['lastCheckOutTime'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('attendance_summaries');

  static Stream<AttendanceSummariesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AttendanceSummariesRecord.fromSnapshot(s));

  static Future<AttendanceSummariesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AttendanceSummariesRecord.fromSnapshot(s));

  static AttendanceSummariesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AttendanceSummariesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AttendanceSummariesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AttendanceSummariesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AttendanceSummariesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AttendanceSummariesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAttendanceSummariesRecordData({
  String? userId,
  String? month,
  String? date,
  int? hoursWorked,
  String? clockInTime,
  String? clockOutTime,
  String? status,
  int? overtime,
  bool? isRegular,
  DateTime? lastUpdated,
  int? totalHoursWorked,
  int? totalDaysWorked,
  int? regularDays,
  int? overtimeMinutes,
  int? totalMinutesWorked,
  int? minutesWorked,
  double? totalWorkHours,
  double? regularWorkHours,
  double? overtimeWorkHours,
  String? firstCheckInTime,
  String? lastCheckOutTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'month': month,
      'date': date,
      'hoursWorked': hoursWorked,
      'clockInTime': clockInTime,
      'clockOutTime': clockOutTime,
      'status': status,
      'overtime': overtime,
      'isRegular': isRegular,
      'lastUpdated': lastUpdated,
      'totalHoursWorked': totalHoursWorked,
      'totalDaysWorked': totalDaysWorked,
      'regularDays': regularDays,
      'overtimeMinutes': overtimeMinutes,
      'totalMinutesWorked': totalMinutesWorked,
      'minutesWorked': minutesWorked,
      'totalWorkHours': totalWorkHours,
      'regularWorkHours': regularWorkHours,
      'overtimeWorkHours': overtimeWorkHours,
      'firstCheckInTime': firstCheckInTime,
      'lastCheckOutTime': lastCheckOutTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class AttendanceSummariesRecordDocumentEquality
    implements Equality<AttendanceSummariesRecord> {
  const AttendanceSummariesRecordDocumentEquality();

  @override
  bool equals(AttendanceSummariesRecord? e1, AttendanceSummariesRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.month == e2?.month &&
        e1?.date == e2?.date &&
        e1?.hoursWorked == e2?.hoursWorked &&
        e1?.clockInTime == e2?.clockInTime &&
        e1?.clockOutTime == e2?.clockOutTime &&
        e1?.status == e2?.status &&
        e1?.overtime == e2?.overtime &&
        e1?.isRegular == e2?.isRegular &&
        e1?.lastUpdated == e2?.lastUpdated &&
        e1?.totalHoursWorked == e2?.totalHoursWorked &&
        e1?.totalDaysWorked == e2?.totalDaysWorked &&
        e1?.regularDays == e2?.regularDays &&
        e1?.overtimeMinutes == e2?.overtimeMinutes &&
        e1?.totalMinutesWorked == e2?.totalMinutesWorked &&
        e1?.minutesWorked == e2?.minutesWorked &&
        e1?.totalWorkHours == e2?.totalWorkHours &&
        e1?.regularWorkHours == e2?.regularWorkHours &&
        e1?.overtimeWorkHours == e2?.overtimeWorkHours &&
        e1?.firstCheckInTime == e2?.firstCheckInTime &&
        e1?.lastCheckOutTime == e2?.lastCheckOutTime;
  }

  @override
  int hash(AttendanceSummariesRecord? e) => const ListEquality().hash([
        e?.userId,
        e?.month,
        e?.date,
        e?.hoursWorked,
        e?.clockInTime,
        e?.clockOutTime,
        e?.status,
        e?.overtime,
        e?.isRegular,
        e?.lastUpdated,
        e?.totalHoursWorked,
        e?.totalDaysWorked,
        e?.regularDays,
        e?.overtimeMinutes,
        e?.totalMinutesWorked,
        e?.minutesWorked,
        e?.totalWorkHours,
        e?.regularWorkHours,
        e?.overtimeWorkHours,
        e?.firstCheckInTime,
        e?.lastCheckOutTime
      ]);

  @override
  bool isValidKey(Object? o) => o is AttendanceSummariesRecord;
}
