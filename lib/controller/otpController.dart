import 'package:flutter/material.dart';

class OtpController extends ChangeNotifier {
  // String? smsCode;
  String? verificationId;
  int? resendToken;

  void addVerificationId(String id) {
    verificationId = id;
    notifyListeners();
  }

  void addResendToken(int? token) {
    resendToken = token;
    notifyListeners();
  }

  // addSmsCode(String code) {
  //   smsCode = code;
  //   notifyListeners();
  // }
}
