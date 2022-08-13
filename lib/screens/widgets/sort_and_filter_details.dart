import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/check_box.dart';
import '../../state/app_state.dart';
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

  final List<CheckBoxState> filterList;
  final List<String> filters;
  final int totalDisplayed;
  final int totalTransactions;

  Container filterContainer(String e, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF4863A0).withOpacity(0.4),
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
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Align(
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD3D3D3),
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 1.0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 10,
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
                      width: 10,
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
            const SizedBox(
              height: 10,
            ),
            (filters.isEmpty)
                ? const SizedBox()
                : SizedBox(
                    height: 35,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...filters
                            .map(
                              (e) => filterContainer(e, context),
                            )
                            .toList(),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
