import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AadhaarCardsRecord extends FirestoreRecord {
  AadhaarCardsRecord._(
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

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "isVerified" field.
  bool? _isVerified;
  bool get isVerified => _isVerified ?? false;
  bool hasIsVerified() => _isVerified != null;

  // "aadharNumber" field.
  String? _aadharNumber;
  String get aadharNumber => _aadharNumber ?? '';
  bool hasAadharNumber() => _aadharNumber != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  void _initializeFields() {
    _frontImageUrl = snapshotData['frontImageUrl'] as String?;
    _backImageUrl = snapshotData['backImageUrl'] as String?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
    _isVerified = snapshotData['isVerified'] as bool?;
    _aadharNumber = snapshotData['aadharNumber'] as String?;
    _uid = snapshotData['uid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('aadhaar_cards');

  static Stream<AadhaarCardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AadhaarCardsRecord.fromSnapshot(s));

  static Future<AadhaarCardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AadhaarCardsRecord.fromSnapshot(s));

  static AadhaarCardsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AadhaarCardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AadhaarCardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AadhaarCardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AadhaarCardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AadhaarCardsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAadhaarCardsRecordData({
  String? frontImageUrl,
  String? backImageUrl,
  DateTime? updatedAt,
  bool? isVerified,
  String? aadharNumber,
  String? uid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'frontImageUrl': frontImageUrl,
      'backImageUrl': backImageUrl,
      'updatedAt': updatedAt,
      'isVerified': isVerified,
      'aadharNumber': aadharNumber,
      'uid': uid,
    }.withoutNulls,
  );

  return firestoreData;
}

class AadhaarCardsRecordDocumentEquality
    implements Equality<AadhaarCardsRecord> {
  const AadhaarCardsRecordDocumentEquality();

  @override
  bool equals(AadhaarCardsRecord? e1, AadhaarCardsRecord? e2) {
    return e1?.frontImageUrl == e2?.frontImageUrl &&
        e1?.backImageUrl == e2?.backImageUrl &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.isVerified == e2?.isVerified &&
        e1?.aadharNumber == e2?.aadharNumber &&
        e1?.uid == e2?.uid;
  }

  @override
  int hash(AadhaarCardsRecord? e) => const ListEquality().hash([
        e?.frontImageUrl,
        e?.backImageUrl,
        e?.updatedAt,
        e?.isVerified,
        e?.aadharNumber,
        e?.uid
      ]);

  @override
  bool isValidKey(Object? o) => o is AadhaarCardsRecord;
}
