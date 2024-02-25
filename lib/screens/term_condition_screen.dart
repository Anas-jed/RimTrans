import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../export_all.dart';
import '../models/term_condition_model.dart';

class TermAndConditionScreen extends StatefulWidget {
  const TermAndConditionScreen({super.key});

  static Future start(BuildContext context) {
    if (Platform.isIOS) {
      return Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => const TermAndConditionScreen()));
    } else {
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const TermAndConditionScreen()));
    }
  }

  @override
  State<TermAndConditionScreen> createState() => _TermAndConditionScreenState();
}

class _TermAndConditionScreenState extends State<TermAndConditionScreen> {
  TermAndConditionModel? termAndConditionModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      termAndConditionModel = await ApiService().getTermAndCondition();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBarWidget(
            // text: 'Term And Condition',
            text: termAndConditionModel?.message ?? 'Term And Condition',
            onBackTap: () async {
              // showTransactionIdBottomSheet(context);
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : termAndConditionModel == null
                      ? Center(
                          child: Text(
                            'No terms to display',
                            style: Constant.kMediumTextStyle
                                .copyWith(fontSize: 16),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var item
                                    in termAndConditionModel!.banks) ...[
                                  Text(
                                    item.title,
                                    style: Constant.kMediumTextStyle
                                        .copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    item.content,
                                    style: Constant.kRegularTextStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                ]
                              ]
                              // [

                              // Text(
                              //   'Information collection and use',
                              //   style: Constant.kMediumTextStyle.copyWith(fontSize: 16),
                              // ),
                              // Text(
                              //   Constant.termsAndConditionText1,
                              //   style: Constant.kRegularTextStyle.copyWith(fontSize: 14),
                              // ),
                              // const SizedBox(
                              //   height: 20.0,
                              // ),
                              // Text(
                              //   'Device related information',
                              //   style: Constant.kMediumTextStyle.copyWith(fontSize: 16),
                              // ),
                              // Text(
                              //   Constant.termsAndConditionText2,
                              // ),
                              // ],
                              ),
                        ))),
    );
  }
}
