import 'package:flutter/material.dart';
import '../../models/transactions.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.formattedDate,
    required this.transactions,
  }) : super(key: key);

  final String formattedDate;
  final Transactions transactions;
  final double dateFontSize = 18;
  final double descpFontSize = 22;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                formattedDate,
                style: TextStyle(
                  fontSize: dateFontSize,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transactions.description,
                  style: TextStyle(
                    fontSize: descpFontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "₹ ${transactions.amount}",
                  style: TextStyle(
                    fontSize: 20,
                    color: (transactions.type == "CREDIT")
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
  }
}
