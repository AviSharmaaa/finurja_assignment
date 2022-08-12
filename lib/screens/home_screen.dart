import 'package:finurja_assignment/models/check_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/banks.dart';
import '../models/transactions.dart';
import '../state/app_state.dart';
import 'widgets/bank_details.dart';
import 'widgets/sort_and_filter_details.dart';
import 'widgets/transactions_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AppState>(context, listen: false).readBanks();
      Provider.of<AppState>(context, listen: false).readTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, provider, child) {
      if (provider.getActiveBank == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        Banks activeBank = provider.getActiveBank!;
        List<Transactions> transactionList = provider.sortedList();
        List<CheckBoxState> filterList = provider.getFilterList;
        List<String> filters = provider.getFilters;
        int totalTransactions = provider.getTotalActiveTransactions;
        int totalDisplayed = provider.getTotalTransactionsDisplayed;
        return Column(
          children: [
            BankDetails(
              bank: activeBank,
            ),
            SortAndFilterDetails(
              totalTransactions: totalTransactions,
              totalDisplayed: totalDisplayed,
              filters: filters,
              filterList: filterList,
            ),
            TransactionList(
              transactionsList: transactionList,
            ),
          ],
        );
      }
    });
  }
}
