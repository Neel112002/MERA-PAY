import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _KYCwizardStep1 = prefs.getBool('ff_KYCwizardStep1') ?? _KYCwizardStep1;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _countryCode = '';
  String get countryCode => _countryCode;
  set countryCode(String value) {
    _countryCode = value;
  }

  bool _KYCwizardStep1 = false;
  bool get KYCwizardStep1 => _KYCwizardStep1;
  set KYCwizardStep1(bool value) {
    _KYCwizardStep1 = value;
    prefs.setBool('ff_KYCwizardStep1', value);
  }

  String _aadharNumber = '';
  String get aadharNumber => _aadharNumber;
  set aadharNumber(String value) {
    _aadharNumber = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
