import 'dart:developer';

import 'package:flutter/material.dart';

import '../export_all.dart';

void showTransactionIdBottomSheet(context, List<Bank> bankList) {
  Bank? selectedBankModel;

  showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 38.0, horizontal: 26.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trasnsaction Id Help',
                          style:
                              Constant.kMediumTextStyle.copyWith(fontSize: 22),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: const Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(15)),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 24.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SpringWidget(
                      onTap: () async {
                        (Bank?, int) data =
                            await showSenderBankBottomSheet(context, bankList);
                        // final result = data as String;
                        if (data.$1 != null) {
                          log(data.$1!.bankName);
                          setState(() {
                            selectedBankModel = data.$1;
                          });
                        }
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (selectedBankModel != null) ...[
                                  CachedNetworkImage(
                                    imageUrl: selectedBankModel!.logo,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(Constant.noPhoto),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                ],
                                Text(
                                  // ignore: unnecessary_null_comparison
                                  selectedBankModel == null
                                      ? 'Select Bank'
                                      : selectedBankModel!.bankName,
                                  style: Constant.kMediumTextStyle.copyWith(
                                      fontSize: 13,
                                      color:
                                          darkTextColorNewTransactionBottomSheet),
                                ),
                              ],
                            ),
                            if (selectedBankModel == null)
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: darkTextColorNewTransactionBottomSheet,
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      height: 1,
                      color: disableGreyColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Type',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: const Color(0xffabbbbd)),
                        ),
                        Text(
                          'General',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: disableGreyColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: const Color(0xffabbbbd)),
                        ),
                        Text(
                          'Completed',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: disableGreyColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Address',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: const Color(0xffabbbbd)),
                        ),
                        Text(
                          'xxxxxxxxxxxxxxxxxxxxxx',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: const Color(0xffabbbbd)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: disableGreyColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fee',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: const Color(0xffabbbbd)),
                        ),
                        Text(
                          '0.4138983492 USDT',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: disableGreyColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TxID',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: const Color(0xffabbbbd)),
                        ),
                        Text(
                          'xxxxxxxxxxxxxxxxxxxxxx',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: disableGreyColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: Constant.kMediumTextStyle
                              .copyWith(color: const Color(0xffabbbbd)),
                        ),
                        Text(
                          DateTime.now().toUtc().toString(),
                          style: Constant.kMediumTextStyle
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: disableGreyColor,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ]),
                ),
                const Spacer(),
                CustomButton(
                  text: 'Got it',
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
      });
}
