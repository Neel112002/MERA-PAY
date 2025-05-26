import '/components/kyc_app_bar/kyc_app_bar_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'kyc_step1_widget.dart' show KycStep1Widget;
import 'package:flutter/material.dart';

class KycStep1Model extends FlutterFlowModel<KycStep1Widget> {
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
