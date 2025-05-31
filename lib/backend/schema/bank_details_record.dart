import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BankDetailsRecord extends FirestoreRecord {
  BankDetailsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "BankName" field.
  List<String>? _bankName;
  List<String> get bankName => _bankName ?? const [];
  bool hasBankName() => _bankName != null;

  // "AccountNumber" field.
  List<String>? _accountNumber;
  List<String> get accountNumber => _accountNumber ?? const [];
  bool hasAccountNumber() => _accountNumber != null;

  // "BranchName" field.
  List<String>? _branchName;
  List<String> get branchName => _branchName ?? const [];
  bool hasBranchName() => _branchName != null;

  // "IFSCCode" field.
  List<String>? _iFSCCode;
  List<String> get iFSCCode => _iFSCCode ?? const [];
  bool hasIFSCCode() => _iFSCCode != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _bankName = getDataList(snapshotData['BankName']);
    _accountNumber = getDataList(snapshotData['AccountNumber']);
    _branchName = getDataList(snapshotData['BranchName']);
    _iFSCCode = getDataList(snapshotData['IFSCCode']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bankDetails');

  static Stream<BankDetailsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BankDetailsRecord.fromSnapshot(s));

  static Future<BankDetailsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BankDetailsRecord.fromSnapshot(s));

  static BankDetailsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BankDetailsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BankDetailsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BankDetailsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BankDetailsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BankDetailsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBankDetailsRecordData({
  String? uid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
    }.withoutNulls,
  );

  return firestoreData;
}

class BankDetailsRecordDocumentEquality implements Equality<BankDetailsRecord> {
  const BankDetailsRecordDocumentEquality();

  @override
  bool equals(BankDetailsRecord? e1, BankDetailsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.uid == e2?.uid &&
        listEquality.equals(e1?.bankName, e2?.bankName) &&
        listEquality.equals(e1?.accountNumber, e2?.accountNumber) &&
        listEquality.equals(e1?.branchName, e2?.branchName) &&
        listEquality.equals(e1?.iFSCCode, e2?.iFSCCode);
  }

  @override
  int hash(BankDetailsRecord? e) => const ListEquality().hash(
      [e?.uid, e?.bankName, e?.accountNumber, e?.branchName, e?.iFSCCode]);

  @override
  bool isValidKey(Object? o) => o is BankDetailsRecord;
}
