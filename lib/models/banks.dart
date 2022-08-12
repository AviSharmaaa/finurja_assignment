// To parse this JSON data, do
//
//     final banks = banksFromJson(jsonString);

import 'dart:convert';

List<Banks> banksFromJson(String str) =>
    List<Banks>.from(json.decode(str).map((x) => Banks.fromJson(x)));

String banksToJson(List<Banks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banks {
  Banks({
    required this.fipId,
    required this.fipName,
    required this.balance,
    required this.accountType,
    required this.accountNumber,
    required this.accountId,
  });

  String fipId;
  String fipName;
  int balance;
  String accountType;
  String accountNumber;
  String accountId;

  factory Banks.fromJson(Map<String, dynamic> json) => Banks(
        fipId: json["fipId"],
        fipName: json["fipName"],
        balance: json["balance"],
        accountType: json["accountType"],
        accountNumber: json["accountNumber"],
        accountId: json["accountId"],
      );

  Map<String, dynamic> toJson() => {
        "fipId": fipId,
        "fipName": fipName,
        "balance": balance,
        "accountType": accountType,
        "accountNumber": accountNumber,
        "accountId": accountId,
      };
}
