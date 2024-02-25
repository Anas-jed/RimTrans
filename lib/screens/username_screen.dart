import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../export_all.dart';

class UsernameScreen extends StatefulWidget {
  final String numberToSend;
  const UsernameScreen({super.key, required this.numberToSend});

  static Future start(BuildContext context, {required String numberToSend}) {
    if (Platform.isIOS) {
      return Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => UsernameScreen(
                    numberToSend: numberToSend,
                  )));
    } else {
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UsernameScreen(
                    numberToSend: numberToSend,
                  )));
    }
  }

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  FocusNode myFocusNode = FocusNode();
  TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myFocusNode.requestFocus();
      ToastContext().init(context);
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 32.0),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              GestureDetector(
                onTap: () {
                  myFocusNode.unfocus();
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
                  'Enter Username',
                  style: Constant.kMediumTextStyle.copyWith(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                focusNode: myFocusNode,
                keyboardType: TextInputType.text,
                controller: userNameController,
                validator: (value) {
                  if (value == '') {
                    return 'Value must not be empty';
                  }
                  return null;
                },
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
                    hintText: 'Enter Username'),
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
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        FocusScope.of(context).unfocus();
                        String phoneNo = widget.numberToSend;
                        phoneNo = phoneNo.split(Constant.countryCodePak).last;
                        log('value: $phoneNo');
                        phoneNo = '0$phoneNo';
                        log('value: $phoneNo');

                        ApiService.signUp(
                                username: userNameController.text.trim(),
                                phoneNo: phoneNo)
                            .then((value) {
                          if (value == true) {
                            PinScreen.start(context, isPinExist: false);
                          } else {
                            Toast.show("Sign Up failed",
                                backgroundRadius: 10,
                                duration: Toast.lengthLong,
                                gravity: Toast.center);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: isLoading
                          ? const EdgeInsets.all(15)
                          : EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: isLoading
                          ? const SizedBox(
                              height: 5,
                              width: 5,
                              child: CircularProgressIndicator(
                                strokeCap: StrokeCap.round,
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.chevron_right_rounded,
                              size: 28.0,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
