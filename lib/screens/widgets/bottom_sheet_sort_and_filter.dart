import 'package:finurja_assignment/models/check_box.dart';
import 'package:finurja_assignment/models/radio_button.dart';
import 'package:finurja_assignment/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetSortAndFilter extends StatefulWidget {
  const BottomSheetSortAndFilter({Key? key}) : super(key: key);

  @override
  State<BottomSheetSortAndFilter> createState() =>
      _BottomSheetSortAndFilterState();
}

class _BottomSheetSortAndFilterState extends State<BottomSheetSortAndFilter> {
  final double horizontalPadding = 25.0;

  final double verticalPadding = 20.0;

  String radioVal = "assend";
  bool checkVal = true;

  AppState provider = AppState();
  List<CheckBoxState> filterList = [];
  List<RadioButton> sortList = [];
  List<String> filters = [];
  List<String> sortOptions = [];
  String? selectedSortOption;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AppState>(context, listen: false);
    filterList = provider.getFilterList;
    sortList = provider.getSortList;
    filters = provider.getFilters;
    sortOptions = provider.getSortOptions;
    selectedSortOption = provider.getSelectedSortOption ?? sortOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sort & Filter",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close_outlined,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 2,
          indent: 20,
          endIndent: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Time se sort karein"),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  children: [
                    ...sortList.map((e) => (singleRadioButton(e))).toList(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Filter By"),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  children: [
                    ...filterList.map((e) => (singleCheckBox(e))).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              onPressed: () {
                provider.setFilters = <String>[];
                for (var e in filterList) {
                  e.value = false;
                }
                provider.setFiltersList = filterList;
                provider.setSelectedSortOption = sortOptions.first;
                Navigator.pop(context);
              },
              child: const Text("Reset"),
            ),
            ElevatedButton(
              onPressed: () {
                provider.setFilters = filters;
                provider.setSelectedSortOption = selectedSortOption;
                Navigator.pop(context);
              },
              child: const Text("Apply"),
            ),
          ],
        )
      ],
    );
  }

  RadioListTile<String> singleRadioButton(RadioButton radio) {
    return RadioListTile(
      value: radio.value,
      groupValue: selectedSortOption,
      onChanged: (String? value) {
        setState(() {
          selectedSortOption = value!;
        });
      },
      title: Text(radio.title),
    );
  }

  CheckboxListTile singleCheckBox(CheckBoxState checkbox) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: checkbox.value,
      title: Text(checkbox.title),
      onChanged: (value) {
        setState(() {
          checkbox.value = value!;
        });
        if (checkbox.value) {
          filters.add(checkbox.title);
        } else {
          filters.remove(checkbox.title);
        }
      },
    );
  }
}
