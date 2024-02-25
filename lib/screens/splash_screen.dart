import 'package:flutter/material.dart';

import '../export_all.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      WelcomeScreen.start(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Constant.logoIcon),
                  Text(
                    'RimTrans',
                    style: Constant.kBoldTextStyle
                        .copyWith(fontSize: 20, color: const Color(0xff003d99)),
                  ),
                  Text(
                    'Quick and Easy',
                    style: Constant.kMediumTextStyle
                        .copyWith(fontSize: 12, color: const Color(0xff575757)),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 5.0,
                      strokeCap: StrokeCap.round,
                      backgroundColor: Color(0xffe7e7e7),
                      color: Color(0xff003d99),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Copyright © All Rights Reserved',
                    style: Constant.kRegularTextStyle
                        .copyWith(fontSize: 8, color: const Color(0xff333333)),
                  ),
                  Text(
                    'RimTrans 2023',
                    style: Constant.kBoldTextStyle
                        .copyWith(fontSize: 8, color: const Color(0xff333333)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
