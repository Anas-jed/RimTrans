import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../export_all.dart';

class PhoneNoScreen extends StatefulWidget {
  const PhoneNoScreen({super.key});

  static Future start(BuildContext context) {
    if (Platform.isIOS) {
      return Navigator.push(context,
          CupertinoPageRoute(builder: (context) => const PhoneNoScreen()));
    } else {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PhoneNoScreen()));
    }
  }

  @override
  State<PhoneNoScreen> createState() => _PhoneNoScreenState();
}

class _PhoneNoScreenState extends State<PhoneNoScreen> {
  FocusNode myFocusNode = FocusNode();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myFocusNode.requestFocus();
    });
  }

  // @override
  // void dispose() {
  //   // myFocusNode.dispose();
  //   // phoneController.dispose();
  //   super.dispose();
  // }

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
                myFocusNode.unfocus();
                // if(myFocusNode.hasFocus)
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
                'Enter Phone Number',
                style: Constant.kMediumTextStyle.copyWith(fontSize: 24),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'You ‘ll get a verification code on given no.',
                textAlign: TextAlign.center,
                style: Constant.kRegularTextStyle.copyWith(fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              focusNode: myFocusNode,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  fillColor: disableGreyColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                        20,
                      )),
                  prefixIcon: Container(
                    height: 60,
                    width: 60,
                    margin:
                        const EdgeInsets.only(right: 15.0, top: 0, bottom: 0),
                    padding: const EdgeInsets.all(16.0),
                    // padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.asset(
                        Constant.usFlag,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                  hintText: 'Enter Phone Number'),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'By signing up you agree to \n',
                    style: Constant.kRegularTextStyle.copyWith(fontSize: 13),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Terms & conditions',
                          style: Constant.kRegularTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                      TextSpan(
                          text: ' of RimTrans',
                          style: Constant.kRegularTextStyle
                              .copyWith(fontSize: 13)),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    //0596201881
                    FocusScope.of(context).unfocus();
                    log('Entered Phone Number ${phoneController.text.trim()}');
                    String phoneNumber = phoneController.text.trim();
                    phoneNumber = phoneNumber.substring(1);
                    phoneNumber = Constant.countryCodePak + phoneNumber;
                    //"+966539403474"
                    FirebaseAuthHandler.sendOtpToNumber(
                        phoneNumber, context, null);
                    OtpScreen.start(context, numberToSend: phoneNumber
                        // phoneController.text.trim()
                        );
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
