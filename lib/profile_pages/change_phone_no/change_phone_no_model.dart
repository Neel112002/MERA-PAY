import '/flutter_flow/flutter_flow_util.dart';
import 'change_phone_no_widget.dart' show ChangePhoneNoWidget;
import 'package:flutter/material.dart';

class ChangePhoneNoModel extends FlutterFlowModel<ChangePhoneNoWidget> {
  ///  Local state fields for this page.

  String newNumber = '\"\"';

  ///  State fields for stateful widgets in this page.

  // State field(s) for CurrentEmail widget.
  FocusNode? currentEmailFocusNode;
  TextEditingController? currentEmailTextController;
  String? Function(BuildContext, String?)? currentEmailTextControllerValidator;
  // State field(s) for newEmail widget.
  FocusNode? newEmailFocusNode;
  TextEditingController? newEmailTextController;
  String? Function(BuildContext, String?)? newEmailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    currentEmailFocusNode?.dispose();
    currentEmailTextController?.dispose();

    newEmailFocusNode?.dispose();
    newEmailTextController?.dispose();
  }
}
