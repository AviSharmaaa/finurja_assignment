import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../models/transactions.dart';
import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    required this.transactionsList,
  }) : super(key: key);

  final List<Transactions> transactionsList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: transactionsList.length,
        itemBuilder: (context, index) {
          DateTime date = transactionsList[index].timestamp;
          String formattedDate = DateFormat("dd/MM/yyy").format(date);
          Transactions transactions = transactionsList[index];
          return TransactionCard(formattedDate: formattedDate, transactions: transactions);
        },
      ),
    );
  }
}

