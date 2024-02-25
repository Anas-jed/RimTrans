import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../export_all.dart';
import '../models/term_condition_model.dart' as TAC;

class ApiService {
  static String baseUrl = 'https://rimtransfer.ukeepmee.com/api/';

  Future<TAC.TermAndConditionModel?> getTermAndCondition() async {
    try {
      Uri uri = Uri.parse('${baseUrl}terms');
      var response = await http.get(uri);

      // log('response body : ${response.body.toString()}');

      TAC.TermAndConditionModel termAndConditionModel =
          TAC.termAndConditionModelFromJson(response.body.toString());

      return termAndConditionModel;
    } catch (e) {
      log('API: Term And Condition $e');
      return null;
    }
  }

  static Future<bool> signUp(
      {required String username, required String phoneNo}) async {
    try {
      Uri uri = Uri.parse('${baseUrl}signup');
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      var response = await http.post(uri, body: {
        'name': username,
        'mobile': phoneNo,
        'devicetype': 'android',
        'device_id': androidInfo.id,
        'password': '12345678',
      });

      log('response body : ${response.body.toString()}');

      var jsonDecoded = json.decode(response.body);

      if (response.statusCode == 200 && jsonDecoded['status'] == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log('API: SignUp $e');
      return false;
    }
  }

  Future<TransactionListModel?> getTransactionList(String userId) async {
    try {
      Uri uri = Uri.parse('${baseUrl}get_transactions?user_id=$userId');
      var response = await http.get(uri);

      // log('response body : ${response.body.toString()}');

      TransactionListModel transactionListModel =
          transactionListModelFromJson(response.body.toString());

      return transactionListModel;
    } catch (e) {
      log('API: Getting Transaction List $e');
      return null;
    }
  }

  Future<List<Bank>?> getBankList() async {
    try {
      Uri uri = Uri.parse('${baseUrl}get_banks');
      var response = await http.get(uri);

      // log('response body : ${response.body.toString()}');

      BankModel bankModel = bankModelFromJson(response.body.toString());

      return bankModel.banks;
    } catch (e) {
      log('API: Getting Bank Model List $e');
      return null;
    }
  }

  Future<bool> saveTransaction(
      {required Transaction transaction,
      required File file,
      required String fileName}) async {
    try {
      Map<String, String> headers = {"Content-type": "multipart/form-data"};

      var request = http.MultipartRequest(
          "POST", Uri.parse('${baseUrl}save_transaction'));

      request.headers.addAll(headers);

      request.fields.addAll({
        'sender_phone': transaction.senderPhone,
        'sender_name': transaction.senderName,
        'sender_bank_id': transaction.senderBankId,
        'amount': transaction.amount,
        'receiver_name': transaction.receiverName,
        'receiver_phone': transaction.receiverPhone,
        'receiver_bank_id': transaction.receiverBankId,
        'txn_id': transaction.txnId,
        'user_id': transaction.userId,
        'status': 0.toString(),
      });

      request.files.add(http.MultipartFile.fromBytes(
          'image', file.readAsBytesSync(),
          filename: fileName));

      var res = await request.send();
      final response = await http.Response.fromStream(res);

      log('response body : ${response.body.toString()}');

      // Uri uri = Uri.parse('${baseUrl}save_transaction');
      // var response = await http.post(uri, body: {
      //   'sender_phone': transaction.senderPhone,
      //   'sender_name': transaction.senderName,
      //   'sender_bank_id': transaction.senderBankId,
      //   'amount': transaction.amount,
      //   'receiver_name': transaction.receiverName,
      //   'receiver_phone': transaction.receiverPhone,
      //   'receiver_bank_id': transaction.receiverBankId,
      //   'txn_id': transaction.txnId,
      //   'user_id': transaction.userId,
      //   'status': 0.toString(),
      // });

      // log('response body : ${response.body.toString()}');

      if (response.statusCode == 200) {
        var resJson = json.decode(response.body);
        if (resJson['status'] == 200) {
          return true;
        }
      }
      return false;
    } catch (e) {
      log('API: Saving Transaction $e');
      return false;
    }
  }
}
