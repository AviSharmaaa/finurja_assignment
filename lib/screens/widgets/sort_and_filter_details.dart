import 'package:finurja_assignment/models/check_box.dart';
import 'package:finurja_assignment/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_sheet_sort_and_filter.dart';
import 'modal_bottom_sheet.dart';

class SortAndFilterDetails extends StatelessWidget {
  const SortAndFilterDetails({
    Key? key,
    required this.totalTransactions,
    required this.totalDisplayed,
    required this.filters,
    required this.filterList,
  }) : super(key: key);

  final int totalTransactions;
  final int totalDisplayed;
  final List<String> filters;
  final List<CheckBoxState> filterList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Showing $totalDisplayed of $totalTransactions",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () => modalBottomSheet(
                      context,
                      const BottomSheetSortAndFilter(),
                    ),
                    child: const Icon(
                      Icons.filter_alt,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...filters.map((e) => filterContainer(e, context)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container filterContainer(String e, BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e.toUpperCase(),
            ),
            Align(
              // alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  filters.remove(e);
                  Provider.of<AppState>(
                    context,
                    listen: false,
                  ).setFilters = filters;

                  if (e.toUpperCase() == "CREDIT") {
                    filterList[0].value = false;
                  } else {
                    filterList[1].value = false;
                  }
                },
                child: const Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
