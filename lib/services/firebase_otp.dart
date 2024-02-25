import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../export_all.dart';

class FirebaseAuthHandler {
  static OtpController otpController = OtpController();

  static sendOtpToNumber(
      String number, var context, int? forceResendToken) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    log('OTP Number $number');
    await auth.verifyPhoneNumber(
      phoneNumber: number, //'+44 7123 123 456'
      timeout: const Duration(seconds: 30),
      forceResendingToken: forceResendToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        log('phone is verified ${credential.asMap().toString()}');
        await auth.signInWithCredential(credential);
        UsernameScreen.start(context, numberToSend: number);
      },
      verificationFailed: (FirebaseAuthException error) {
        log('verification Failed; $error');
        ToastContext().init(context);
        Toast.show("Verification Failed",
            backgroundRadius: 10,
            duration: Toast.lengthLong,
            gravity: Toast.bottom);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        log('code Sent $verificationId $forceResendingToken');
        otpController.addVerificationId(verificationId);
        otpController.addResendToken(forceResendingToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('codeAutoRetrievalTimeout $verificationId');
      },
    );
  }

  static verifyOtp(String smsCode, String number, var context) {
    try {
      String? verificationId = otpController.verificationId;
      log('verifyOtp called VerificationID: $verificationId $smsCode');
      if (verificationId != null) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        log('Credential Complete ${credential.signInMethod}');
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        firebaseAuth.signInWithCredential(credential);
        log('Firebase SignIn Complete ${firebaseAuth.currentUser?.uid}');
        UsernameScreen.start(context, numberToSend: number);
      }
    } catch (e) {
      log('Exception Caught :: $e');
    }
  }

  // static resendSms() async{
  //    try {
  //     int? resendToken = otpController.resendToken;
  //     log('resendSms called resendToken: $resendToken');
  //     if (resendToken != null) {
  //           FirebaseAuth auth = FirebaseAuth.instance;
  //       await auth.verifyPhoneNumber(verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
  //     }
  //   } catch (e) {
  //     log('Exception Caught :: $e');
  //   }
  // }
}
