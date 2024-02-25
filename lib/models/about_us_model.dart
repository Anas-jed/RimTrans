// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) =>
    AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  int status;
  bool error;
  String message;
  List<Bank> banks;

  AboutUsModel({
    required this.status,
    required this.error,
    required this.message,
    required this.banks,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
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
  String title;
  String content;

  Bank({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
      };
}
