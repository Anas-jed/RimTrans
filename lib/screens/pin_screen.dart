import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../export_all.dart';

class PinScreen extends StatefulWidget {
  final bool isPinExist;
  const PinScreen({super.key, required this.isPinExist});

  static Future start(BuildContext context, {required bool isPinExist}) {
    if (Platform.isIOS) {
      return Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => PinScreen(
                    isPinExist: isPinExist,
                  )));
    } else {
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PinScreen(isPinExist: isPinExist)));
    }
  }

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  FocusNode myFocusNode = FocusNode();
  TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myFocusNode.requestFocus();
      ToastContext().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 32.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            if (!widget.isPinExist)
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
                'PIN',
                style: Constant.kMediumTextStyle.copyWith(fontSize: 24),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.isPinExist ? 'Enter 4 digit pin' : 'Set 4 digit pin',
                textAlign: TextAlign.center,
                style: Constant.kRegularTextStyle.copyWith(fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: PinCodeTextField(
                length: 4,
                appContext: context,
                controller: pinController,
                focusNode: myFocusNode,
                keyboardType: TextInputType.number,
                obscureText: true,
                enableActiveFill: true,
                cursorColor: primaryColor,
                autoUnfocus: false,
                onCompleted: (value) {
                  executeOnTap();
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    // bool value = await LocalStorage.prefs.clear();
                    // log(value.toString());
                    executeOnTap();
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

  void executeOnTap() {
    if (pinController.text.length == 4) {
      if (widget.isPinExist) {
        int? value = LocalStorage.getPass();
        if (value != null) {
          if (pinController.text == value.toString()) {
            OnBoardingScreen.start(context);
            FocusScope.of(context).unfocus();
          } else {
            Toast.show("Invalid Pin entered",
                backgroundRadius: 10,
                duration: Toast.lengthLong,
                gravity: Toast.center);
          }
        } else {
          FocusScope.of(context).unfocus();
          LocalStorage.addPass(pass: int.parse(pinController.text));
          OnBoardingScreen.start(context);
        }
      } else {
        FocusScope.of(context).unfocus();
        LocalStorage.addPass(pass: int.parse(pinController.text));
        OnBoardingScreen.start(context);
      }
    } else {
      Toast.show("Please enter 4 digit pin to continue",
          backgroundRadius: 10,
          duration: Toast.lengthLong,
          gravity: Toast.center);
    }
  }
}
