import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bank_accounts_widget.dart' show BankAccountsWidget;
import 'package:flutter/material.dart';

class BankAccountsModel extends FlutterFlowModel<BankAccountsWidget> {
  ///  Local state fields for this component.

  String? bankName;

  String? accountNumber;

  String? iFSCcode;

  String? branchName;

  BankDetailsRecord? bankList;

  List<String> bankNameList = [];
  void addToBankNameList(String item) => bankNameList.add(item);
  void removeFromBankNameList(String item) => bankNameList.remove(item);
  void removeAtIndexFromBankNameList(int index) => bankNameList.removeAt(index);
  void insertAtIndexInBankNameList(int index, String item) =>
      bankNameList.insert(index, item);
  void updateBankNameListAtIndex(int index, Function(String) updateFn) =>
      bankNameList[index] = updateFn(bankNameList[index]);

  List<String> accountNumberList = [];
  void addToAccountNumberList(String item) => accountNumberList.add(item);
  void removeFromAccountNumberList(String item) =>
      accountNumberList.remove(item);
  void removeAtIndexFromAccountNumberList(int index) =>
      accountNumberList.removeAt(index);
  void insertAtIndexInAccountNumberList(int index, String item) =>
      accountNumberList.insert(index, item);
  void updateAccountNumberListAtIndex(int index, Function(String) updateFn) =>
      accountNumberList[index] = updateFn(accountNumberList[index]);

  List<String> ifscCodeList = [];
  void addToIfscCodeList(String item) => ifscCodeList.add(item);
  void removeFromIfscCodeList(String item) => ifscCodeList.remove(item);
  void removeAtIndexFromIfscCodeList(int index) => ifscCodeList.removeAt(index);
  void insertAtIndexInIfscCodeList(int index, String item) =>
      ifscCodeList.insert(index, item);
  void updateIfscCodeListAtIndex(int index, Function(String) updateFn) =>
      ifscCodeList[index] = updateFn(ifscCodeList[index]);

  List<String> branchNameList = [];
  void addToBranchNameList(String item) => branchNameList.add(item);
  void removeFromBranchNameList(String item) => branchNameList.remove(item);
  void removeAtIndexFromBranchNameList(int index) =>
      branchNameList.removeAt(index);
  void insertAtIndexInBranchNameList(int index, String item) =>
      branchNameList.insert(index, item);
  void updateBranchNameListAtIndex(int index, Function(String) updateFn) =>
      branchNameList[index] = updateFn(branchNameList[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in BankAccounts widget.
  BankDetailsRecord? addedBanks;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  SelectedBankRecord? bankDetials;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
