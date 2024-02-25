import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../export_all.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static Future start(BuildContext context) {
    if (Platform.isIOS) {
      return Navigator.push(context,
          CupertinoPageRoute(builder: (context) => const WelcomeScreen()));
    } else {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    }
  }

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool dismissBarrier = false;
  int selectedLanguageIndex = -1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showModalBottomSheet(
          context: context,
          isDismissible: false,
          // constraints: BoxConstraints(
          //     minHeight: MediaQuery.of(context).size.height * 0.45),
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                height: MediaQuery.of(context).size.height * 0.6,
                // width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 38.0, horizontal: 26.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Text(
                      Constant.text1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        Constant.text2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 100,
                      child: FlagWidget(
                        selectedIndex: (value) {
                          setState(() {
                            selectedLanguageIndex = value;
                          });
                        },
                      ),
                    ),
                    // const Spacer(),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                        text: 'Continue',
                        isDisable: selectedLanguageIndex != -1 ? false : true,
                        onTap: () {
                          Navigator.pop(context);
                        })
                  ]),
                ),
              );
            });
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SvgPicture.asset(Constant.logoIcon)),
                  const SizedBox(
                    height: 40,
                  ),
                  SvgPicture.asset(Constant.background,
                      width: MediaQuery.of(context).size.width),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      Constant.text3,
                      textAlign: TextAlign.center,
                      style: Constant.kMediumTextStyle.copyWith(fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      Constant.text4,
                      textAlign: TextAlign.center,
                      style: Constant.kRegularTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                ]),
                // const Spacer(),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      // PinScreen.start(context, isPinExist: false);
                      PhoneNoScreen.start(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: disableGreyColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  padding: const EdgeInsets.all(16.0),
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
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text('Your Mobile Number')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Align(
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //         prefix: Container(
                //       decoration:
                //           BoxDecoration(borderRadius: BorderRadius.circular(20)),
                //       child: SvgPicture.asset(Constant.usFlag),
                //     )),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
