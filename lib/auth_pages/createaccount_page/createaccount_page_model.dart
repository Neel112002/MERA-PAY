import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'createaccount_page_widget.dart' show CreateaccountPageWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateaccountPageModel extends FlutterFlowModel<CreateaccountPageWidget> {
  ///  Local state fields for this page.

  String email = '\"\"';

  String password = '\"\"';

  String phonenumber = '\"\"';

  String monthlysalary = '\"\"';

  String accountnumber = '\"\"';

  String bankname = '\"\"';

  String username = '\"\"';

  double? age;

  String gender = '\"\"';

  ///  State fields for stateful widgets in this page.

  // State field(s) for phonenumber widget.
  FocusNode? phonenumberFocusNode;
  TextEditingController? phonenumberTextController;
  final phonenumberMask = MaskTextInputFormatter(mask: '+91 ##########');
  String? Function(BuildContext, String?)? phonenumberTextControllerValidator;
  // State field(s) for username widget.
  FocusNode? usernameFocusNode;
  TextEditingController? usernameTextController;
  String? Function(BuildContext, String?)? usernameTextControllerValidator;
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
  // State field(s) for age widget.
  FocusNode? ageFocusNode;
  TextEditingController? ageTextController;
  String? Function(BuildContext, String?)? ageTextControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordConfirmVisibility = false;
  }

  @override
  void dispose() {
    phonenumberFocusNode?.dispose();
    phonenumberTextController?.dispose();

    usernameFocusNode?.dispose();
    usernameTextController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmTextController?.dispose();

    ageFocusNode?.dispose();
    ageTextController?.dispose();
  }
}
