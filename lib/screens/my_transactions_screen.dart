import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../export_all.dart';

class MyTransactionsScreen extends StatefulWidget {
  const MyTransactionsScreen({super.key});

  static Future start(BuildContext context) {
    if (Platform.isIOS) {
      return Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => const MyTransactionsScreen()));
    } else {
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyTransactionsScreen()));
    }
  }

  @override
  State<MyTransactionsScreen> createState() => _MyTransactionsScreenState();
}

class _MyTransactionsScreenState extends State<MyTransactionsScreen> {
  TransactionListModel? transactionListModel;
  List<Bank>? bankList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      transactionListModel = await ApiService().getTransactionList('394');
      bankList = await ApiService().getBankList();
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget emptyList() {
    return const Center(
      child: Text('Empty List'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 32.0),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : transactionListModel == null
                  ? emptyList()
                  : transactionListModel!.transactions.isEmpty
                      ? emptyList()
                      : Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(Constant.logoIcon),
                              Row(
                                children: [
                                  SvgPicture.asset(Constant.whatsappIcon),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    Constant.notificationIcon,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SpringWidget(
                                    onTap: () {
                                      SettingsScreen.start(context);
                                    },
                                    child: SvgPicture.asset(
                                      Constant.settingsIcon,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Transactions',
                                style: Constant.kMediumTextStyle.copyWith(
                                    fontSize: 22,
                                    color:
                                        darkTextColorNewTransactionBottomSheet),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: disableGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SvgPicture.asset(
                                            Constant.searchIcon)),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: disableGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.filter_list_outlined,
                                        size: 18.0,
                                        color: iconColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        height: 30,
                                        // width: ,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: disableGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          'History',
                                          style: Constant.kMediumTextStyle
                                              .copyWith(fontSize: 13),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                ListView.separated(
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(),
                                    itemCount: transactionListModel!
                                        .transactions.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 10.0,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      final item = transactionListModel!
                                          .transactions[index];
                                      return Container(
                                        height: 125,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.3))),
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 30,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: item.status ==
                                                            'Inprogress'
                                                        ? const Color(
                                                            0xffffe9cf)
                                                        : const Color(
                                                                0xff24a738)
                                                            .withOpacity(0.14)),
                                                child: Text(
                                                  'Status: ${item.status}',
                                                  style: Constant
                                                      .kRegularTextStyle
                                                      .copyWith(
                                                          fontSize: 10,
                                                          color: item.status ==
                                                                  'Inprogress'
                                                              ? const Color(
                                                                  0xff855c2e)
                                                              : const Color(
                                                                  0xff1c932d)),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: RichText(
                                                  text: TextSpan(
                                                      text:
                                                          '${item.amount.toString()}  ',
                                                      style: Constant
                                                          .kMediumTextStyle
                                                          .copyWith(
                                                              fontSize: 18),
                                                      children: [
                                                        TextSpan(
                                                          text: 'MRU',
                                                          style: Constant
                                                              .kRegularTextStyle
                                                              .copyWith(
                                                                  fontSize: 10),
                                                        )
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Sender',
                                                    style: Constant
                                                        .kRegularTextStyle
                                                        .copyWith(
                                                            fontSize: 12,
                                                            color: const Color(
                                                                0xff999999)),
                                                  ),
                                                  Text(
                                                    item.senderName,
                                                    style: Constant
                                                        .kMediumTextStyle
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color:
                                                                darkTextColorNewTransactionBottomSheet),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Receiver',
                                                    style: Constant
                                                        .kRegularTextStyle
                                                        .copyWith(
                                                            fontSize: 12,
                                                            color: const Color(
                                                                0xff999999)),
                                                  ),
                                                  Text(
                                                    item.receiverName,
                                                    style: Constant
                                                        .kMediumTextStyle
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color:
                                                                darkTextColorNewTransactionBottomSheet),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ]),
                                      );
                                    }),
                                // const Spacer(),
                                Positioned(
                                  bottom: 50,
                                  right: 10,
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: SpringWidget(
                                        onTap: () {
                                          // log('tapped');
                                          showNewTransactionBottomSheet(
                                              context, bankList!);
                                          // log(LocalStorage.getPass().toString());
                                        },
                                        child: Container(
                                          height: 55,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SvgPicture.asset(Constant
                                                    .editTransactionIcon),
                                                Text(
                                                  'New Transaction',
                                                  style: Constant
                                                      .kMediumTextStyle
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                )
                                              ]),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          )
                        ]),
        ),
      ),
    );
  }
}
