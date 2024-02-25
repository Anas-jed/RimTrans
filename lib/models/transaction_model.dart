// To parse this JSON data, do
//
//     final transactionListModel = transactionListModelFromJson(jsonString);

import 'dart:convert';

TransactionListModel transactionListModelFromJson(String str) =>
    TransactionListModel.fromJson(json.decode(str));

String transactionListModelToJson(TransactionListModel data) =>
    json.encode(data.toJson());

class TransactionListModel {
  int status;
  bool error;
  String message;
  List<Transaction> transactions;

  TransactionListModel({
    required this.status,
    required this.error,
    required this.message,
    required this.transactions,
  });

  factory TransactionListModel.fromJson(Map<String, dynamic> json) =>
      TransactionListModel(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transaction {
  String id;
  String senderName;
  String senderPhone;
  String senderBankId;
  String amount;
  String receiverName;
  String receiverPhone;
  String receiverBankId;
  String txnId;
  String image;
  String userId;
  DateTime createdDate;
  String status;

  Transaction({
    required this.id,
    required this.senderName,
    required this.senderPhone,
    required this.senderBankId,
    required this.amount,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverBankId,
    required this.txnId,
    required this.image,
    required this.userId,
    required this.createdDate,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        senderName: json["sender_name"],
        senderPhone: json["sender_phone"],
        senderBankId: json["sender_bank_id"],
        amount: json["amount"],
        receiverName: json["receiver_name"],
        receiverPhone: json["receiver_phone"],
        receiverBankId: json["receiver_bank_id"],
        txnId: json["txn_id"],
        image: json["image"],
        userId: json["user_id"],
        createdDate: DateTime.parse(json["created_date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_name": senderName,
        "sender_phone": senderPhone,
        "sender_bank_id": senderBankId,
        "amount": amount,
        "receiver_name": receiverName,
        "receiver_phone": receiverPhone,
        "receiver_bank_id": receiverBankId,
        "txn_id": txnId,
        "image": image,
        "user_id": userId,
        "created_date": createdDate.toIso8601String(),
        "status": status,
      };
}
