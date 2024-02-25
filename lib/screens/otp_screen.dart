import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../export_all.dart';

class OtpScreen extends StatefulWidget {
  final String numberToSend;
  const OtpScreen({super.key, required this.numberToSend});

  static Future start(BuildContext context, {required String numberToSend}) {
    if (Platform.isIOS) {
      return Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => OtpScreen(
                    numberToSend: numberToSend,
                  )));
    } else {
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    numberToSend: numberToSend,
                  )));
    }
  }

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  FocusNode myFocusNode = FocusNode();
  TextEditingController otpController = TextEditingController();
  Timer? timer;
  int countDown = 30;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myFocusNode.requestFocus();
    });
    startTimer();
  }

  startTimer() async {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown != 0) {
        setState(() {
          countDown = countDown - 1;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    otpController.dispose();

    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 32.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: disableGreyColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    size: 28.0,
                    color: iconColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Number Verification',
                style: Constant.kMediumTextStyle.copyWith(fontSize: 24),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Enter 6 digit code sent to 009xxxxxxx',
                textAlign: TextAlign.center,
                style: Constant.kRegularTextStyle.copyWith(fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: PinCodeTextField(
                length: 6,
                appContext: context,
                controller: otpController,
                focusNode: myFocusNode,
                keyboardType: TextInputType.number,
                obscureText: true,
                enableActiveFill: true,
                cursorColor: primaryColor,
                onCompleted: (value) {
                  log('Entered Value: $value');
                  FirebaseAuthHandler.verifyOtp(
                      value, widget.numberToSend, context);
                },
                pinTheme: PinTheme(
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeColor: disableGreyColor,
                  inactiveColor: disableGreyColor,
                  selectedColor: disableGreyColor,
                  selectedFillColor: disableGreyColor,
                  shape: PinCodeFieldShape.box,
                  inactiveFillColor: disableGreyColor,
                  activeFillColor: disableGreyColor,
                ),
              ),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpringWidget(
                      onTap: countDown == 0
                          ? () {
                              log('tapped');

                              OtpController otpController = OtpController();

                              log('ForceREsendingToke:N ${otpController.resendToken}');

                              FirebaseAuthHandler.sendOtpToNumber(
                                  widget.numberToSend,
                                  context,
                                  otpController.resendToken);
                              setState(() {
                                countDown = 30;
                                startTimer();
                              });
                            }
                          : null,
                      child: Text('Resend SMS',
                          style: Constant.kRegularTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  countDown == 0 ? primaryColor : Colors.grey)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('00:${countDown.toString().padLeft(2, '0')}',
                        style: Constant.kRegularTextStyle
                            .copyWith(color: textGreyColor)),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // FocusScope.of(context).unfocus();
                    // UsernameScreen.start(context);
                    FirebaseAuthHandler.verifyOtp(
                        otpController.text, widget.numberToSend, context);
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        size: 28.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
