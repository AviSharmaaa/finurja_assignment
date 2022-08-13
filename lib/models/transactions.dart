import 'dart:convert';

List<Transactions> transactionsFromJson(String str) => List<Transactions>.from(
    json.decode(str).map((x) => Transactions.fromJson(x)));

String transactionsToJson(List<Transactions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transactions {
  Transactions({
    required this.fipId,
    required this.accountNumber,
    required this.amount,
    required this.type,
    required this.accountId,
    required this.description,
    required this.timestamp,
  });

  String fipId;
  String accountNumber;
  int amount;
  String type;
  String accountId;
  String description;
  DateTime timestamp;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        fipId: json["fipId"],
        accountNumber: json["accountNumber"],
        amount: json["amount"],
        type: json["type"],
        accountId: json["accountId"],
        description: json["description"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "fipId": fipId,
        "accountNumber": accountNumber,
        "amount": amount,
        "type": type,
        "accountId": accountId,
        "description": description,
        "timestamp": timestamp.toIso8601String(),
      };
}
