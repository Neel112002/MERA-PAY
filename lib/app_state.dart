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
    _safeInit(() {
      _kycStep2 = prefs.getBool('ff_kycStep2') ?? _kycStep2;
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

  bool _aadharverification = false;
  bool get aadharverification => _aadharverification;
  set aadharverification(bool value) {
    _aadharverification = value;
  }

  String _panNumber = '';
  String get panNumber => _panNumber;
  set panNumber(String value) {
    _panNumber = value;
  }

  bool _panverification = false;
  bool get panverification => _panverification;
  set panverification(bool value) {
    _panverification = value;
  }

  String _payslipNumber = '';
  String get payslipNumber => _payslipNumber;
  set payslipNumber(String value) {
    _payslipNumber = value;
  }

  bool _payslipverification = false;
  bool get payslipverification => _payslipverification;
  set payslipverification(bool value) {
    _payslipverification = value;
  }

  bool _kycStep2 = false;
  bool get kycStep2 => _kycStep2;
  set kycStep2(bool value) {
    _kycStep2 = value;
    prefs.setBool('ff_kycStep2', value);
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
