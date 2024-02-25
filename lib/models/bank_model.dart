// class BankModel {
//   final int id;
//   final String bankName;
//   final String asset;
//   final bool isActive;

//   BankModel(
//       {required this.id,
//       required this.bankName,
//       required this.asset,
//       required this.isActive});
// }

// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
    int status;
    bool error;
    String message;
    List<Bank> banks;

    BankModel({
        required this.status,
        required this.error,
        required this.message,
        required this.banks,
    });

    factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
    };
}

class Bank {
    String id;
    String bankName;
    String balance;
    String logo;
    String status;
    DateTime createdAt;

    Bank({
        required this.id,
        required this.bankName,
        required this.balance,
        required this.logo,
        required this.status,
        required this.createdAt,
    });

    factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        bankName: json["bank_name"],
        balance: json["balance"],
        logo: json["logo"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "balance": balance,
        "logo": logo,
        "status": status,
        "created_at": createdAt.toIso8601String(),
    };
}

