import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  VerificationsRecord? checkIfVerificationExists;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  VerificationsRecord? verifyTableCreated;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  SelectedBankRecord? selectedBankExists;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  SelectedBankRecord? selectedBank;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  SelfiesRecord? serfieTableExists;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  SelfiesRecord? selfietablecreated;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  @override
  void dispose() {
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}
