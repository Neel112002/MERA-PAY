import '/components/kyc_app_bar/kyc_app_bar_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'identity_verification_page_widget.dart'
    show IdentityVerificationPageWidget;
import 'package:flutter/material.dart';

class IdentityVerificationPageModel
    extends FlutterFlowModel<IdentityVerificationPageWidget> {
  ///  Local state fields for this page.

  double progressStat = 0.0;

  String progressPercentage = '0%';

  String? dateofBirth;

  bool aadharUpload = false;

  bool panUpload = false;

  bool payslipUpload = false;

  bool paySlipDetails = false;

  bool uploadSelfie = false;

  ///  State fields for stateful widgets in this page.

  // Model for KYC_APP_BAR component.
  late KycAppBarModel kycAppBarModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextFieldpayperiod widget.
  FocusNode? textFieldpayperiodFocusNode;
  TextEditingController? textFieldpayperiodTextController;
  String? Function(BuildContext, String?)?
      textFieldpayperiodTextControllerValidator;
  // State field(s) for TextFieldpaydate widget.
  FocusNode? textFieldpaydateFocusNode;
  TextEditingController? textFieldpaydateTextController;
  String? Function(BuildContext, String?)?
      textFieldpaydateTextControllerValidator;
  DateTime? datePicked1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  // State field(s) for TextFielddateofjoin widget.
  FocusNode? textFielddateofjoinFocusNode;
  TextEditingController? textFielddateofjoinTextController;
  String? Function(BuildContext, String?)?
      textFielddateofjoinTextControllerValidator;
  DateTime? datePicked2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController8;
  String? Function(BuildContext, String?)? textController8Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController9;
  String? Function(BuildContext, String?)? textController9Validator;
  // State field(s) for TextFieldNetSalary widget.
  FocusNode? textFieldNetSalaryFocusNode;
  TextEditingController? textFieldNetSalaryTextController;
  String? Function(BuildContext, String?)?
      textFieldNetSalaryTextControllerValidator;
  // Model for Navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    kycAppBarModel = createModel(context, () => KycAppBarModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    kycAppBarModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldpayperiodFocusNode?.dispose();
    textFieldpayperiodTextController?.dispose();

    textFieldpaydateFocusNode?.dispose();
    textFieldpaydateTextController?.dispose();

    textFieldFocusNode3?.dispose();
    textController5?.dispose();

    textFieldFocusNode4?.dispose();
    textController6?.dispose();

    textFielddateofjoinFocusNode?.dispose();
    textFielddateofjoinTextController?.dispose();

    textFieldFocusNode5?.dispose();
    textController8?.dispose();

    textFieldFocusNode6?.dispose();
    textController9?.dispose();

    textFieldNetSalaryFocusNode?.dispose();
    textFieldNetSalaryTextController?.dispose();

    navbarModel.dispose();
  }
}
