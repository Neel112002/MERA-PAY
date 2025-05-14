import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'createaccount_widget.dart' show CreateaccountWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateaccountModel extends FlutterFlowModel<CreateaccountWidget> {
  ///  Local state fields for this page.

  String email = '\"\"';

  String password = '\"\"';

  String phonenumber = '\"\"';

  String monthlysalary = '\"\"';

  String accountnumber = '\"\"';

  String bankname = '\"\"';

  ///  State fields for stateful widgets in this page.

  // State field(s) for phonenumber widget.
  FocusNode? phonenumberFocusNode;
  TextEditingController? phonenumberTextController;
  final phonenumberMask = MaskTextInputFormatter(mask: '+91 ##########');
  String? Function(BuildContext, String?)? phonenumberTextControllerValidator;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for passwordConfirm widget.
  FocusNode? passwordConfirmFocusNode;
  TextEditingController? passwordConfirmTextController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)?
      passwordConfirmTextControllerValidator;
  // State field(s) for Montly_Salary widget.
  FocusNode? montlySalaryFocusNode;
  TextEditingController? montlySalaryTextController;
  String? Function(BuildContext, String?)? montlySalaryTextControllerValidator;
  // State field(s) for BankName widget.
  FocusNode? bankNameFocusNode;
  TextEditingController? bankNameTextController;
  String? Function(BuildContext, String?)? bankNameTextControllerValidator;
  // State field(s) for AccountNumber widget.
  FocusNode? accountNumberFocusNode;
  TextEditingController? accountNumberTextController;
  final accountNumberMask = MaskTextInputFormatter(mask: '##############');
  String? Function(BuildContext, String?)? accountNumberTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordConfirmVisibility = false;
  }

  @override
  void dispose() {
    phonenumberFocusNode?.dispose();
    phonenumberTextController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmTextController?.dispose();

    montlySalaryFocusNode?.dispose();
    montlySalaryTextController?.dispose();

    bankNameFocusNode?.dispose();
    bankNameTextController?.dispose();

    accountNumberFocusNode?.dispose();
    accountNumberTextController?.dispose();
  }
}
