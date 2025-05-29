import '/components/kyc_app_bar/kyc_app_bar_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'k_y_c_complete_page_widget.dart' show KYCCompletePageWidget;
import 'package:flutter/material.dart';

class KYCCompletePageModel extends FlutterFlowModel<KYCCompletePageWidget> {
  ///  Local state fields for this page.

  double progressStat = 0.0;

  String progressPercentage = '0%';

  String? dateofBirth;

  bool aadharUpload = false;

  bool panUpload = false;

  bool payslipUpload = false;

  bool paySlipDetails = false;

  ///  State fields for stateful widgets in this page.

  // Model for KYC_APP_BAR component.
  late KycAppBarModel kycAppBarModel;
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
    navbarModel.dispose();
  }
}
