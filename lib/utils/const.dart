import 'package:flutter/material.dart';

import '../export_all.dart';

class Constant {
  static String icons = 'assets/icons/';
  static String images = 'assets/images/';
  static String fontFamily = 'assets/fonts/OpenSans';

  ///ICONS
  static String logoIcon = '${icons}logo.svg';
  static String searchIcon = '${icons}search.svg';
  static String closeIcon = '${icons}close.svg';
  static String personRoundIcon = '${icons}person_roundBorder.svg';
  static String editTransactionIcon = '${icons}edit_transaction.svg';
  static String whatsappIcon = '${icons}whatsapp.svg';
  static String settingsIcon = '${icons}settings.svg';
  static String notificationIcon = '${icons}notification.svg';

  static String usFlag = '${images}us_flag.png';
  static String arabFlag = '${images}arab_flag.png';
  static String franceFlag = '${images}france_flag.png';
  static String background = '${images}background.svg';
  static String bank1 = '${images}bank1.png';
  static String bank2 = '${images}bank2.png';
  static String noPhoto = '${images}no-photo.png';

  static String countryCodeUS = '+1';
  static String countryCodePak = '+92';
  static String countryCodeKsa = '+966';

  ///TEXT STYLE
  static final kLightTextStyle = TextStyle(
      fontFamily: fontFamily, color: Colors.black, fontWeight: FontWeight.w300);

  static final kRegularTextStyle = TextStyle(
      fontFamily: fontFamily, color: Colors.black, fontWeight: FontWeight.w400);

  static final kMediumTextStyle = TextStyle(
      fontFamily: fontFamily, color: Colors.black, fontWeight: FontWeight.w500);

  static final kSemiBoldTextStyle = TextStyle(
      fontFamily: fontFamily, color: Colors.black, fontWeight: FontWeight.w600);

  static final kBoldTextStyle = TextStyle(
      fontFamily: fontFamily, color: Colors.black, fontWeight: FontWeight.w700);

  static final kExtraBoldTextStyle = TextStyle(
      fontFamily: fontFamily, color: Colors.black, fontWeight: FontWeight.w800);

  static String text1 = 'Your preferred Lanuguage';

  static String text2 =
      'You can change your preference later in khaalis app settings';

  static String text3 =
      'RimTrans is a simple and secure way to send money to friends and family';

  static String text4 =
      'With more power packed into a single app send payments near and far, and much more.';

  static String termsAndConditionText1 =
      '''This Privacy Policy explains the disclosure, collection, and use of information in connection with our mobile application, website, and other products (collectively, the
"Services"), so that you can better understand how your information is used and the information is used.
"Personal Information," as used in this Privacy Policy, is information that specifically identifies an individual, such as an individual's name, address, telephone number, or email address. Personal information also includes information about an individual's activities, such as information about their activity on our Services, demographic information, and region.
By accessing or using our Services, you are indicating that you have read, understood, and consent to the disclosure, use, storage, and collection of your personal information as described in this Privacy Policy.
If you do not agree to the terms of this Privacy Policy, please do not use the Services.''';

  static String termsAndConditionText2 = '''
Information collected by the Services includes:
Information that you provide to us directly, such as your name and email address if you sign up for an account with the Services, or if you contact our support team.
We may retain any message, message attachments, or other information you choose to provide through the Services or via email or telephone correspondence with our team. This may include your name, email address, and phone

Diagnostic data that does not contain personal information may be collected to diagnose and fix errors in the services provided.
Usage information collected automatically via cookies.
Please refer to our Cookie Policy for details of how we use cookies and similar technology to collect
''';

  static List<FlagModel> flagList = [
    FlagModel(name: 'English', asset: usFlag),
    FlagModel(name: 'France', asset: franceFlag),
    FlagModel(name: 'Arabic', asset: arabFlag)
  ];

  static List<FeeGuideModel> feeGuideList = [
    FeeGuideModel(range: '100 - 2.000', fee: '20 MRU'),
    FeeGuideModel(range: '2.001 - 4.000', fee: '30 MRU'),
    FeeGuideModel(range: '2.001 - 8000', fee: '40 MRU'),
    FeeGuideModel(range: '8001 - 12.000', fee: '60 MRU'),
    FeeGuideModel(range: '12.001 - 16000', fee: '70 MRU'),
    FeeGuideModel(range: '16001 - 20.000', fee: '80 MRU'),
    FeeGuideModel(range: '20.001 - 24.000', fee: '100 MRU'),
    FeeGuideModel(range: '24.001 - 30.000', fee: '110 MRU'),
  ];

  // static List<Bank> bankList = [
  //   Bank(id: '1', bankName: 'Capital One', asset: bank1, isActive: true),
  //   Bank(id: '2', bankName: 'Chase', asset: bank1, isActive: true),
  //   Bank(
  //       id: '3', bankName: 'Bank Of America', asset: bank2, isActive: false),
  //   Bank(id: '4', bankName: 'Capital One', asset: bank2, isActive: false),
  //   Bank(id: '5', bankName: 'Capital', asset: bank1, isActive: true),
  //   Bank(id: '6', bankName: 'Citi', asset: bank2, isActive: false),
  //   Bank(id: 7, bankName: 'U.S City', asset: bank1, isActive: true),
  //   Bank(id: 8, bankName: 'Capital One', asset: bank2, isActive: false),
  //   Bank(id: 9, bankName: 'Capital One', asset: bank2, isActive: false),
  //   Bank(id: 10, bankName: 'Capital One', asset: bank2, isActive: false),
  //   Bank(id: 11, bankName: 'Capital One', asset: bank2, isActive: false),
  //   Bank(id: 12, bankName: 'Capital One', asset: bank2, isActive: false),
  // ];

  // static List<TransactionModel> transactionList = [
  //   TransactionModel(
  //       senderName: 'Gerard Brock',
  //       receiverName: 'Terri Romero',
  //       status: 'Inprogress',
  //       fee: 2800,
  //       senderBank: '',
  //       receiverBank: ''),
  //   TransactionModel(
  //       senderName: 'Gerard Brock',
  //       receiverName: 'Terri Romero',
  //       status: 'Completed',
  //       fee: 1200,
  //       senderBank: '',
  //       receiverBank: '')
  // ];
}
