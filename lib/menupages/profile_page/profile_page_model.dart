import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataKes = false;
  FFUploadedFile uploadedLocalFile_uploadDataKes =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataKes = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
