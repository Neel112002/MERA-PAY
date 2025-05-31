import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PanCardsRecord extends FirestoreRecord {
  PanCardsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "frontImageUrl" field.
  String? _frontImageUrl;
  String get frontImageUrl => _frontImageUrl ?? '';
  bool hasFrontImageUrl() => _frontImageUrl != null;

  // "backImageUrl" field.
  String? _backImageUrl;
  String get backImageUrl => _backImageUrl ?? '';
  bool hasBackImageUrl() => _backImageUrl != null;

  // "panNumber" field.
  String? _panNumber;
  String get panNumber => _panNumber ?? '';
  bool hasPanNumber() => _panNumber != null;

  // "isVerified" field.
  bool? _isVerified;
  bool get isVerified => _isVerified ?? false;
  bool hasIsVerified() => _isVerified != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  void _initializeFields() {
    _frontImageUrl = snapshotData['frontImageUrl'] as String?;
    _backImageUrl = snapshotData['backImageUrl'] as String?;
    _panNumber = snapshotData['panNumber'] as String?;
    _isVerified = snapshotData['isVerified'] as bool?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
    _uid = snapshotData['uid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('pan_cards');

  static Stream<PanCardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PanCardsRecord.fromSnapshot(s));

  static Future<PanCardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PanCardsRecord.fromSnapshot(s));

  static PanCardsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PanCardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PanCardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PanCardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PanCardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PanCardsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPanCardsRecordData({
  String? frontImageUrl,
  String? backImageUrl,
  String? panNumber,
  bool? isVerified,
  DateTime? updatedAt,
  String? uid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'frontImageUrl': frontImageUrl,
      'backImageUrl': backImageUrl,
      'panNumber': panNumber,
      'isVerified': isVerified,
      'updatedAt': updatedAt,
      'uid': uid,
    }.withoutNulls,
  );

  return firestoreData;
}

class PanCardsRecordDocumentEquality implements Equality<PanCardsRecord> {
  const PanCardsRecordDocumentEquality();

  @override
  bool equals(PanCardsRecord? e1, PanCardsRecord? e2) {
    return e1?.frontImageUrl == e2?.frontImageUrl &&
        e1?.backImageUrl == e2?.backImageUrl &&
        e1?.panNumber == e2?.panNumber &&
        e1?.isVerified == e2?.isVerified &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.uid == e2?.uid;
  }

  @override
  int hash(PanCardsRecord? e) => const ListEquality().hash([
        e?.frontImageUrl,
        e?.backImageUrl,
        e?.panNumber,
        e?.isVerified,
        e?.updatedAt,
        e?.uid
      ]);

  @override
  bool isValidKey(Object? o) => o is PanCardsRecord;
}
