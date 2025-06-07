import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SelectedBankRecord extends FirestoreRecord {
  SelectedBankRecord._(
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
  String? _bankName;
  String get bankName => _bankName ?? '';
  bool hasBankName() => _bankName != null;

  // "AccountNumber" field.
  String? _accountNumber;
  String get accountNumber => _accountNumber ?? '';
  bool hasAccountNumber() => _accountNumber != null;

  // "IFSCCode" field.
  String? _iFSCCode;
  String get iFSCCode => _iFSCCode ?? '';
  bool hasIFSCCode() => _iFSCCode != null;

  // "BranchName" field.
  String? _branchName;
  String get branchName => _branchName ?? '';
  bool hasBranchName() => _branchName != null;

  // "MoneyWithdrawed" field.
  String? _moneyWithdrawed;
  String get moneyWithdrawed => _moneyWithdrawed ?? '';
  bool hasMoneyWithdrawed() => _moneyWithdrawed != null;

  // "TotalWithdraw" field.
  String? _totalWithdraw;
  String get totalWithdraw => _totalWithdraw ?? '';
  bool hasTotalWithdraw() => _totalWithdraw != null;

  // "Credits" field.
  int? _credits;
  int get credits => _credits ?? 0;
  bool hasCredits() => _credits != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _bankName = snapshotData['BankName'] as String?;
    _accountNumber = snapshotData['AccountNumber'] as String?;
    _iFSCCode = snapshotData['IFSCCode'] as String?;
    _branchName = snapshotData['BranchName'] as String?;
    _moneyWithdrawed = snapshotData['MoneyWithdrawed'] as String?;
    _totalWithdraw = snapshotData['TotalWithdraw'] as String?;
    _credits = castToType<int>(snapshotData['Credits']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('SelectedBank');

  static Stream<SelectedBankRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SelectedBankRecord.fromSnapshot(s));

  static Future<SelectedBankRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SelectedBankRecord.fromSnapshot(s));

  static SelectedBankRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SelectedBankRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SelectedBankRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SelectedBankRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SelectedBankRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SelectedBankRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSelectedBankRecordData({
  String? uid,
  String? bankName,
  String? accountNumber,
  String? iFSCCode,
  String? branchName,
  String? moneyWithdrawed,
  String? totalWithdraw,
  int? credits,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'BankName': bankName,
      'AccountNumber': accountNumber,
      'IFSCCode': iFSCCode,
      'BranchName': branchName,
      'MoneyWithdrawed': moneyWithdrawed,
      'TotalWithdraw': totalWithdraw,
      'Credits': credits,
    }.withoutNulls,
  );

  return firestoreData;
}

class SelectedBankRecordDocumentEquality
    implements Equality<SelectedBankRecord> {
  const SelectedBankRecordDocumentEquality();

  @override
  bool equals(SelectedBankRecord? e1, SelectedBankRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.bankName == e2?.bankName &&
        e1?.accountNumber == e2?.accountNumber &&
        e1?.iFSCCode == e2?.iFSCCode &&
        e1?.branchName == e2?.branchName &&
        e1?.moneyWithdrawed == e2?.moneyWithdrawed &&
        e1?.totalWithdraw == e2?.totalWithdraw &&
        e1?.credits == e2?.credits;
  }

  @override
  int hash(SelectedBankRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.bankName,
        e?.accountNumber,
        e?.iFSCCode,
        e?.branchName,
        e?.moneyWithdrawed,
        e?.totalWithdraw,
        e?.credits
      ]);

  @override
  bool isValidKey(Object? o) => o is SelectedBankRecord;
}
