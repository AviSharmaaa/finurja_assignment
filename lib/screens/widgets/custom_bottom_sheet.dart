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
  Banks? activeBank;
  List<Banks> banks = [];
  AppState provider = AppState();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AppState>(context, listen: false);
    banks = provider.getBanksList;
    activeBank = provider.getActiveBank;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        const Divider(
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
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.maximumDensity,
                  vertical: VisualDensity.maximumDensity,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  bank.fipName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
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
          style: ElevatedButton.styleFrom(
            minimumSize: Size(size.width * 0.9, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            provider.setActiveBank = activeBank;
            Navigator.pop(context);
          },
          child: Text("Apply".toUpperCase()),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
