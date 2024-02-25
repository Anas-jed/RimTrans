// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../export_all.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static Future start(BuildContext context) {
    if (Platform.isIOS) {
      return Navigator.push(context,
          CupertinoPageRoute(builder: (context) => const OnBoardingScreen()));
    } else {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
    }
  }

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Bank>? bankList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      bankList = await ApiService().getBankList();
      log('banksList: ${bankList?.length}');
      setState(() {
        isLoading = false;
      });
      ToastContext().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 45,
              ),
              SvgPicture.asset(
                Constant.logoIcon,
                height: 65,
                width: 65,
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                'Hi, Dash',
                textAlign: TextAlign.center,
                style: Constant.kMediumTextStyle.copyWith(fontSize: 22),
              ),
              Text(
                'It’s seems you are\nnew at RimTrans',
                textAlign: TextAlign.center,
                style: Constant.kMediumTextStyle.copyWith(fontSize: 22),
              ),
              const Spacer(),
              Text(
                'How RimTrans work',
                textAlign: TextAlign.center,
                style: Constant.kMediumTextStyle.copyWith(fontSize: 22),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Add your sender and receiver details first and confirm in third step along with payment screenshot in the last step',
                  textAlign: TextAlign.center,
                  style: Constant.kRegularTextStyle.copyWith(fontSize: 18),
                ),
              ),
              const Spacer(),
              CustomButton(
                  text: 'Your first transaction',
                  textStyle: Constant.kMediumTextStyle
                      .copyWith(fontSize: 15, color: Colors.white),
                  suffix: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {
                    if (!isLoading && bankList != null) {
                      showNewTransactionBottomSheet(context, bankList!)
                          .then((value) {
                        MyTransactionsScreen.start(context);
                      });
                    } else {
                      Toast.show("Banks does not exist",
                          backgroundRadius: 10,
                          duration: Toast.lengthLong,
                          gravity: Toast.center);
                    }
                  })
            ]),
      ),
    ));
  }
}
