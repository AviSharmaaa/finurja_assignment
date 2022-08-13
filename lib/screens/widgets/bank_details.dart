import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../models/banks.dart';
import 'custom_bottom_sheet.dart';
import 'modal_bottom_sheet.dart';

class BankDetails extends StatelessWidget {
  const BankDetails({
    Key? key,
    required this.bank,
  }) : super(key: key);

  final Banks bank;

  String convertBalanceToInrFormat(balance) {
    var format = NumberFormat.currency(
      locale: "en_IN",
      decimalDigits: 0,
      symbol: "₹",
    );
    return format.format(balance);
  }

  @override
  Widget build(BuildContext context) {
    final String accBalance = convertBalanceToInrFormat(bank.balance);
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD3D3D3),
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(3.0, 2.0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/${bank.fipId}.svg",
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      bank.fipId,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Text(
                  accBalance,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${bank.accountType} A/C",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => modalBottomSheet(
                  context,
                  const CustomBottomSheet(),
                ),
                child: Text(
                  "Account Badlein",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue.shade700,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
