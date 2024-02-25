import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../export_all.dart';

Future<void> showNewTransactionBottomSheet(context, List<Bank> bankList) async {
  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;
  TextEditingController senderNameController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController senderPhoneController = TextEditingController();
  TextEditingController receiverPhoneController = TextEditingController();
  TextEditingController senderAmountController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();

  late String senderBankId = '', receiverBankId = '';
  late int senderBankIndex = -1, receiverBankIndex = -1;

  final ImagePicker imagePicker = ImagePicker();
  XFile? xFile;
  late File imageFile;
  String? fileName;
  late Transaction newTransaction;

  pickImage() async {
    xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      log(xFile!.path.toString());
      imageFile = File(xFile!.path);
      fileName = basename(imageFile.path);
    }
  }

  ToastContext().init(context);

  NewTransactionController newTransactionController =
      NewTransactionController();

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  bool completeSenderDetail() {
    if (senderNameController.text == '' ||
        senderPhoneController.text == '' ||
        senderAmountController.text == '' ||
        senderBankIndex == -1) {
      Toast.show("Please enter all details to continue",
          backgroundRadius: 10,
          duration: Toast.lengthLong,
          gravity: Toast.center);
      return false;
    } else {
      return true;
    }
  }

  bool completeReceiverDetail() {
    if (receiverNameController.text == '' ||
        receiverPhoneController.text == '' ||
        receiverBankIndex == -1) {
      Toast.show("Please enter all details to continue",
          backgroundRadius: 10,
          duration: Toast.lengthLong,
          gravity: Toast.center);

      return false;
    } else {
      return true;
    }
  }

  bool completeTransactionId() {
    if (transactionIdController.text == '' || fileName == null) {
      Toast.show("Please enter transaction id and attach image to continue",
          backgroundRadius: 10,
          duration: Toast.lengthLong,
          gravity: Toast.bottom);
      return false;
    } else {
      return true;
    }
  }

  void clearAll() {
    senderNameController.clear();
    senderPhoneController.clear();
    senderAmountController.clear();
    senderBankIndex = -1;
    senderBankId = '';
    receiverNameController.clear();
    receiverPhoneController.clear();
    receiverBankIndex = -1;
    receiverBankId = '';
    transactionIdController.clear();
  }

  // Future<bool>
  void saveTransaction({required Transaction transaction}) async {
    log('save Transaction Called }');

    newTransactionController.setIsLoading(true);
    bool value = await ApiService().saveTransaction(
        transaction: transaction, file: imageFile, fileName: fileName!);
    if (value) {
      Navigator.pop(context);
      Toast.show("Transaction saved successfully",
          backgroundRadius: 10,
          duration: Toast.lengthLong,
          gravity: Toast.bottom);
      clearAll();
    } else {
      Navigator.pop(context);
      Toast.show("Failed saving transaction",
          backgroundRadius: 10,
          duration: Toast.lengthLong,
          gravity: Toast.bottom);
      clearAll();
    }

    // log('isLoading value; ${newTransactionController.isLoading}');
    //
  }

  await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.9,
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 4,
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
            child: Column(children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndexPage != 0)
                    GestureDetector(
                      onTap: () {
                        // log('ccc: $currentIndexPage');
                        previousPage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: const Color(0xfff3f3f3),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(Icons.chevron_left_rounded)),
                    ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // log('ccc: $currentIndexPage');
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: const Color(0xfff3f3f3),
                          borderRadius: BorderRadius.circular(15)),
                      child: SvgPicture.asset(
                        Constant.closeIcon,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    currentIndexPage == 0
                        ? 'New Transaction (1/4)'
                        : currentIndexPage == 1
                            ? 'Receiver Details (2/4)'
                            : currentIndexPage == 2
                                ? 'Confrim Details (3/4)'
                                : 'Payment proof  (4/4)',
                    style: Constant.kMediumTextStyle.copyWith(
                        fontSize: 22,
                        color: darkTextColorNewTransactionBottomSheet),
                  ),
                  DotsIndicator(
                    dotsCount: 4,
                    onTap: null,
                    position: currentIndexPage,
                    decorator: DotsDecorator(
                      activeColor: primaryColor,
                      size: const Size.square(9.0),
                      spacing: const EdgeInsets.symmetric(horizontal: 2.0),
                      activeSize: const Size(28.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      log('value: $value');
                      currentIndexPage = value;
                      log('currentPageIndex; $currentIndexPage');
                    });
                  },
                  children: [
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Sender Details',
                              style: Constant.kRegularTextStyle.copyWith(
                                  fontSize: 15,
                                  color:
                                      darkTextColorNewTransactionBottomSheet),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commongHeaderWidget('Sending name'),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: senderNameController,
                                    decoration: InputDecoration(
                                        fillColor: disableGreyColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            )),
                                        hintText: 'Full Name',
                                        hintStyle: Constant.kMediumTextStyle
                                            .copyWith(
                                                fontSize: 13,
                                                color:
                                                    const Color(0xffd9d9d9))),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  commongHeaderWidget('Sender phone number'),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: senderPhoneController,
                                    decoration: InputDecoration(
                                        fillColor: disableGreyColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            )),
                                        hintText: 'Ex: +44 1632 960720',
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              Constant.personRoundIcon),
                                        ),
                                        hintStyle: Constant.kMediumTextStyle
                                            .copyWith(
                                                fontSize: 13,
                                                color:
                                                    const Color(0xffd9d9d9))),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  commongHeaderWidget('Amount to send'),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: senderAmountController,
                                    decoration: InputDecoration(
                                        fillColor: disableGreyColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            )),
                                        hintText: 'Ex: 500 MRU',
                                        hintStyle: Constant.kMediumTextStyle
                                            .copyWith(
                                                fontSize: 13,
                                                color:
                                                    const Color(0xffd9d9d9))),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  commongHeaderWidget('Select sender bank'),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SpringWidget(
                                    onTap: () async {
                                      (
                                        Bank? bankModel,
                                        int selectedIndex
                                      ) values =
                                          await showSenderBankBottomSheet(
                                              context, bankList);
                                      if (values.$1 != null) {
                                        setState(() {
                                          senderBankId = values.$1!.id;
                                          senderBankIndex = values.$2;
                                        });
                                      }
                                      log('selectedBankId: $senderBankId\n selectedBankIndex: $senderBankIndex');
                                    },
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              if (senderBankIndex != -1) ...[
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      bankList[senderBankIndex]
                                                          .logo,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                              Constant.noPhoto),
                                                ),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                              ],
                                              Text(
                                                senderBankIndex == -1
                                                    ? 'Select Bank'
                                                    : bankList[senderBankIndex]
                                                        .bankName,
                                                style: Constant.kMediumTextStyle
                                                    .copyWith(
                                                        fontSize: 13,
                                                        color:
                                                            darkTextColorNewTransactionBottomSheet),
                                              ),
                                            ],
                                          ),
                                          if (senderBankIndex == -1)
                                            const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  darkTextColorNewTransactionBottomSheet,
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const Spacer(),
                                ],
                              ),
                            )
                          ]),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  commongHeaderWidget('Receiver name'),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: receiverNameController,
                                    decoration: InputDecoration(
                                        fillColor: disableGreyColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            )),
                                        hintText: 'Full Name',
                                        hintStyle: Constant.kMediumTextStyle
                                            .copyWith(
                                                fontSize: 13,
                                                color:
                                                    const Color(0xffd9d9d9))),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  commongHeaderWidget('Receiver phone number'),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: receiverPhoneController,
                                    decoration: InputDecoration(
                                        fillColor: disableGreyColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            )),
                                        hintText: 'Ex: +44 1632 960720',
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              Constant.personRoundIcon),
                                        ),
                                        hintStyle: Constant.kMediumTextStyle
                                            .copyWith(
                                                fontSize: 13,
                                                color:
                                                    const Color(0xffd9d9d9))),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  commongHeaderWidget('Select receiver bank'),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SpringWidget(
                                    onTap: () async {
                                      (
                                        Bank? bankModel,
                                        int selectedIndex
                                      ) values =
                                          await showSenderBankBottomSheet(
                                              context, bankList);
                                      if (values.$1 != null) {
                                        setState(() {
                                          receiverBankId = values.$1!.id;
                                          receiverBankIndex = values.$2;
                                        });

                                        log('receiverBankId: $receiverBankId\n receiverBankIndex: $receiverBankIndex');
                                      }
                                    },
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              if (receiverBankIndex != -1) ...[
                                                CachedNetworkImage(
                                                  imageUrl: bankList[
                                                          receiverBankIndex]
                                                      .logo,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                              Constant.noPhoto),
                                                ),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                              ],
                                              Text(
                                                receiverBankIndex == -1
                                                    ? 'Select Bank'
                                                    : bankList[
                                                            receiverBankIndex]
                                                        .bankName,
                                                style: Constant.kMediumTextStyle
                                                    .copyWith(
                                                        fontSize: 13,
                                                        color:
                                                            darkTextColorNewTransactionBottomSheet),
                                              ),
                                            ],
                                          ),
                                          if (receiverBankIndex == -1)
                                            const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  darkTextColorNewTransactionBottomSheet,
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sender Detail',
                                    style: Constant.kMediumTextStyle.copyWith(
                                        fontSize: 16,
                                        color:
                                            darkTextColorNewTransactionBottomSheet),
                                  ),
                                  Text(
                                    'Edit details',
                                    style: Constant.kMediumTextStyle.copyWith(
                                        fontSize: 13,
                                        color: const Color(0xff003d99)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                  color: disableGreyColor,
                                  width: 2.0,
                                ))),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Sender name',
                                            style: Constant.kRegularTextStyle
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: const Color(
                                                        0xff666666)),
                                          ),
                                          Text(
                                            'Sender phone number',
                                            style: Constant.kRegularTextStyle
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: const Color(
                                                        0xff666666)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            senderNameController.text,
                                            style: Constant.kMediumTextStyle
                                                .copyWith(
                                                    fontSize: 15,
                                                    color:
                                                        darkTextColorNewTransactionBottomSheet),
                                          ),
                                          Text(
                                            senderPhoneController.text,
                                            style: Constant.kMediumTextStyle
                                                .copyWith(
                                                    fontSize: 15,
                                                    color:
                                                        darkTextColorNewTransactionBottomSheet),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Sender bank',
                                        style: Constant.kRegularTextStyle
                                            .copyWith(
                                                fontSize: 12,
                                                color: const Color(0xff666666)),
                                      ),
                                      Text(
                                        senderBankIndex == -1
                                            ? 'xxxxx'
                                            : bankList[senderBankIndex]
                                                .bankName,
                                        style: Constant.kMediumTextStyle.copyWith(
                                            fontSize: 15,
                                            color:
                                                darkTextColorNewTransactionBottomSheet),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Amount to send',
                                        style: Constant.kRegularTextStyle
                                            .copyWith(
                                                fontSize: 12,
                                                color: const Color(0xff666666)),
                                      ),
                                      Text(
                                        senderAmountController.text,
                                        style: Constant.kMediumTextStyle.copyWith(
                                            fontSize: 15,
                                            color:
                                                darkTextColorNewTransactionBottomSheet),
                                      ),
                                    ]),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Receiver Detail',
                                    style: Constant.kMediumTextStyle.copyWith(
                                        fontSize: 16,
                                        color:
                                            darkTextColorNewTransactionBottomSheet),
                                  ),
                                  Text(
                                    'Edit details',
                                    style: Constant.kMediumTextStyle.copyWith(
                                        fontSize: 13,
                                        color: const Color(0xff003d99)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                  color: disableGreyColor,
                                  width: 2.0,
                                ))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Receiver name',
                                          style: Constant.kRegularTextStyle
                                              .copyWith(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff666666)),
                                        ),
                                        Text(
                                          'Receiver phone number',
                                          style: Constant.kRegularTextStyle
                                              .copyWith(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff666666)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          receiverNameController.text,
                                          style: Constant.kMediumTextStyle.copyWith(
                                              fontSize: 15,
                                              color:
                                                  darkTextColorNewTransactionBottomSheet),
                                        ),
                                        Text(
                                          receiverPhoneController.text,
                                          style: Constant.kMediumTextStyle.copyWith(
                                              fontSize: 15,
                                              color:
                                                  darkTextColorNewTransactionBottomSheet),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Receiver bank',
                                      style: Constant.kRegularTextStyle
                                          .copyWith(
                                              fontSize: 12,
                                              color: const Color(0xff666666)),
                                    ),
                                    Text(
                                      receiverBankIndex == -1
                                          ? 'xxxxxx'
                                          : bankList[receiverBankIndex]
                                              .bankName,
                                      style: Constant.kMediumTextStyle.copyWith(
                                          fontSize: 15,
                                          color:
                                              darkTextColorNewTransactionBottomSheet),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Either attach transaction screenshot \nor enter your transaction ID',
                                style: Constant.kRegularTextStyle.copyWith(
                                    fontSize: 15,
                                    color:
                                        darkTextColorNewTransactionBottomSheet),
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Upload transaction screenshot',
                                    style: Constant.kMediumTextStyle.copyWith(
                                        fontSize: 16,
                                        color: const Color(0xff4d4d4d)),
                                  ),
                                  CustomButton(
                                    text: 'Upload',
                                    onTap: () {
                                      log('${senderNameController.text} ${senderPhoneController.text} ${senderPhoneController.text} $senderBankIndex $senderBankId \n'
                                          '${receiverNameController.text} ${receiverPhoneController.text} $receiverBankIndex $receiverBankId ');
                                      pickImage();
                                      // log('NewController isloadin: ${newTransactionController.isLoading}');
                                    },
                                    buttonColor:
                                        darkTextColorNewTransactionBottomSheet,
                                    textStyle: Constant.kMediumTextStyle
                                        .copyWith(
                                            fontSize: 12, color: Colors.white),
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                  )
                                ],
                              ),
                              Container(
                                height: 10,
                                width: 25,
                                decoration: BoxDecoration(
                                    color:
                                        darkTextColorNewTransactionBottomSheet,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Transaction ID',
                                    style: Constant.kMediumTextStyle.copyWith(
                                        fontSize: 16,
                                        color:
                                            darkTextColorNewTransactionBottomSheet),
                                  ),
                                  SpringWidget(
                                    onTap: () {
                                      showTransactionIdBottomSheet(
                                          context, bankList);
                                    },
                                    child: Text(
                                      'Help to find ID',
                                      style: Constant.kMediumTextStyle.copyWith(
                                          fontSize: 14, color: primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: transactionIdController,
                                decoration: InputDecoration(
                                    fillColor: disableGreyColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        )),
                                    hintText: 'Ex: TID2134512312',
                                    hintStyle: Constant.kMediumTextStyle
                                        .copyWith(
                                            fontSize: 13,
                                            color: const Color(0xffd9d9d9))),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              if (currentIndexPage != 3)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction Fee',
                            style: Constant.kRegularTextStyle.copyWith(
                                fontSize: 14, color: const Color(0xff666666)),
                          ),
                          Text(
                            'Amount Received',
                            style: Constant.kRegularTextStyle.copyWith(
                                fontSize: 14, color: const Color(0xff666666)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: RichText(
                              text: TextSpan(
                                text: '44 ',
                                style: Constant.kRegularTextStyle
                                    .copyWith(fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'MRU  ',
                                    style: Constant.kRegularTextStyle
                                        .copyWith(fontSize: 12),
                                  ),
                                  TextSpan(
                                    text: 'Fee Guide',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          showTransactionFeeGuideBottomSheet(
                                              context),
                                    style: Constant.kMediumTextStyle.copyWith(
                                        fontSize: 13,
                                        color: const Color(0xff003d99)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: RichText(
                              text: TextSpan(
                                text: '2300 ',
                                style: Constant.kRegularTextStyle
                                    .copyWith(fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'MRU',
                                    style: Constant.kRegularTextStyle
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomButton(
                    text: currentIndexPage == 0
                        ? 'Add Receiver Details (2/4)'
                        : currentIndexPage == 1
                            ? 'Confirm Details (3/4)'
                            : currentIndexPage == 2
                                ? 'Attach Screenshot (4/4)'
                                : 'Confirm and Submit',
                    isLoading: newTransactionController.isLoading,
                    textStyle: Constant.kMediumTextStyle
                        .copyWith(fontSize: 15, color: Colors.white),
                    buttonColor: currentIndexPage != 3
                        ? darkTextColorNewTransactionBottomSheet
                        : const Color(0xff003d99),
                    suffix: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                    onTap: () {
                      senderNameController.text = 'Khalid';
                      senderPhoneController.text = '03310331556';
                      senderAmountController.text = '150';
                      senderBankIndex = 0;
                      senderBankId = '1';
                      receiverNameController.text = 'Lala';
                      receiverPhoneController.text = '03310331559';
                      receiverBankIndex = 0;
                      receiverBankId = '2';
                      // transactionIdController.text = '1234';

                      if (currentIndexPage == 3) {
                        // final userId = LocalStorage.getUserId();
                        // log('UserId; $userId');
                        newTransaction = Transaction(
                          id: '',
                          senderName: senderNameController.text,
                          senderPhone: senderPhoneController.text,
                          senderBankId: senderBankId,
                          amount: senderAmountController.text,
                          receiverName: receiverNameController.text,
                          receiverPhone: receiverPhoneController.text,
                          receiverBankId: receiverBankId,
                          txnId: transactionIdController.text,
                          image: '',
                          userId: 394.toString(),
                          createdDate: DateTime.now(),
                          status: '',
                        );
                      }

                      currentIndexPage == 0
                          ? completeSenderDetail()
                              ? nextPage()
                              : null
                          : currentIndexPage == 1
                              ? completeReceiverDetail()
                                  ? nextPage()
                                  : null
                              : currentIndexPage != 3
                                  ? nextPage()
                                  : completeTransactionId()
                                      ? saveTransaction(
                                          transaction: newTransaction,
                                        )
                                      : null;
                      setState(() {});
                    }),
              ),
            ]),
          );
        });
      });
}
