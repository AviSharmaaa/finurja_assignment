import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/banks.dart';
import '../../state/app_state.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  AppState provider = AppState();
  List<Banks> banks = [];
  Banks? activeBank;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AppState>(context, listen: false);
    banks = provider.getBanksList;
    activeBank = provider.getActiveBank;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 15,
              top: 25,
              bottom: 10,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close_outlined,
                size: 30,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Account chunein",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Account jodein",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 1.5,
          indent: 20,
          endIndent: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: banks.length,
            itemBuilder: (context, index) {
              Banks bank = banks[index];
              return RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(bank.fipId),
                subtitle: Text(
                  "${bank.accountType} A/C  (${bank.accountNumber})",
                ),
                value: bank,
                groupValue: activeBank,
                onChanged: (Banks? value) {
                  setState(() {
                    activeBank = value!;
                  });
                },
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            provider.setActiveBank = activeBank;
            Navigator.pop(context);
          },
          child: const Text("APPLY"),
        ),
      ],
    );
  }
}
