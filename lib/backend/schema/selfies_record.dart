import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SelfiesRecord extends FirestoreRecord {
  SelfiesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "imageUrl" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "isVerified" field.
  bool? _isVerified;
  bool get isVerified => _isVerified ?? false;
  bool hasIsVerified() => _isVerified != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _imageUrl = snapshotData['imageUrl'] as String?;
    _isVerified = snapshotData['isVerified'] as bool?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('selfies');

  static Stream<SelfiesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SelfiesRecord.fromSnapshot(s));

  static Future<SelfiesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SelfiesRecord.fromSnapshot(s));

  static SelfiesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SelfiesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SelfiesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SelfiesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SelfiesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SelfiesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSelfiesRecordData({
  String? uid,
  String? imageUrl,
  bool? isVerified,
  DateTime? updatedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'imageUrl': imageUrl,
      'isVerified': isVerified,
      'updatedAt': updatedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class SelfiesRecordDocumentEquality implements Equality<SelfiesRecord> {
  const SelfiesRecordDocumentEquality();

  @override
  bool equals(SelfiesRecord? e1, SelfiesRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.isVerified == e2?.isVerified &&
        e1?.updatedAt == e2?.updatedAt;
  }

  @override
  int hash(SelfiesRecord? e) => const ListEquality()
      .hash([e?.uid, e?.imageUrl, e?.isVerified, e?.updatedAt]);

  @override
  bool isValidKey(Object? o) => o is SelfiesRecord;
}
