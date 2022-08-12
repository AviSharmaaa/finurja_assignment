// ignore_for_file: prefer_const_constructors
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../models/transactions.dart';

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
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(formattedDate),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(transactionsList[index].description),
                      Text(
                        "₹ ${transactionsList[index].amount}",
                        style: TextStyle(
                          color: (transactionsList[index].type == "CREDIT")
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
