import 'dart:convert';

import 'package:finurja_assignment/models/radio_button.dart';
import 'package:finurja_assignment/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/banks.dart';
import '../models/check_box.dart';

class AppState extends ChangeNotifier {
  List<Banks> _banksList = [];
  List<Transactions> _transactionsList = [];
  List<Transactions> _activeTransactions = [];
  List<String> _filters = [];
  int _totalActiveTransactions = 0;
  int _totalTransactionsDisplayed = 0;

  List<CheckBoxState> _filterList = [
    CheckBoxState(title: "Credit", value: false),
    CheckBoxState(title: "Debit", value: false),
  ];

  final List<String> _sortOptions = ["desc", "aesc"];

  List<RadioButton> _sortList = [
    RadioButton(title: "Naye se Purane", value: "desc"),
    RadioButton(title: "Purane se naye", value: "aesc"),
  ];

  Banks? _activeBank;
  String? _selectedSortOption;

  void readBanks() async {
    List<Banks> banks = [];
    final data = await rootBundle.loadString("assets/json/banks.json");
    final list = await jsonDecode(data) as List<dynamic>;

    banks = list.map((e) => Banks.fromJson(e)).toList();
    setBanksList = banks;
    setActiveBank = banks[0];
  }

  void readTransactions() async {
    List<Transactions> transactions = [];
    final data = await rootBundle.loadString("assets/json/output.json");
    final list = jsonDecode(data) as List<dynamic>;

    transactions = list.map((e) => Transactions.fromJson(e)).toList();
    setTransactionsList = transactions;
  }

  List<Transactions> sortedList() {
    String? option = _selectedSortOption;
    List<Transactions> list = filterTransactions();
    if (option == null || option == "desc") {
      list.sort((a, b) => (b.timestamp.compareTo(a.timestamp)));
    } else {
      list.sort((a, b) => (a.timestamp.compareTo(b.timestamp)));
    }

    setTotalTransactionsDisplayed = list.length;
    return list;
  }

  List<Transactions> readActiveTransactions() {
    List<Transactions> list = [];
    for (Transactions transaction in _transactionsList) {
      if (transaction.accountId == _activeBank!.accountId) {
        list.add(transaction);
      }
    }

    setTotalActiveTransactions = list.length;

    return list;
  }

  List<Transactions> filterTransactions() {
    List<Transactions> list = readActiveTransactions();
    if (_filters.isEmpty) {
      return list;
    } else {
      List<Transactions> filteredList = [];
      for (String filter in _filters) {
        for (Transactions transaction in list) {
          if (transaction.type == filter.toUpperCase()) {
            filteredList.add(transaction);
          }
        }
      }
      return filteredList;
    }
  }

  Banks? get getActiveBank => _activeBank;
  List<Banks> get getBanksList => _banksList;
  List<Transactions> get getTransactionsList => _transactionsList;
  List<Transactions> get getActiveTransactions => _activeTransactions;
  List<CheckBoxState> get getFilterList => _filterList;
  List<String> get getFilters => _filters;
  List<RadioButton> get getSortList => _sortList;
  List<String> get getSortOptions => _sortOptions;
  String? get getSelectedSortOption => _selectedSortOption;
  int get getTotalActiveTransactions => _totalActiveTransactions;
  int get getTotalTransactionsDisplayed => _totalTransactionsDisplayed;

  set setTotalActiveTransactions(value) {
    _totalActiveTransactions = value;
  }

  set setTotalTransactionsDisplayed(value) {
    _totalTransactionsDisplayed = value;
  }

  set setSelectedSortOption(value) {
    _selectedSortOption = value;
    notifyListeners();
  }

  set setSortList(value) {
    _sortList = value;
    notifyListeners();
  }

  set setBanksList(value) {
    _banksList = value;
    notifyListeners();
  }

  set setFiltersList(value) {
    _filterList = value;
    notifyListeners();
  }

  set setFilters(value) {
    _filters = value;
    notifyListeners();
  }

  set setTransactionsList(value) {
    _transactionsList = value;
    notifyListeners();
  }

  set setActiveBank(value) {
    _activeBank = value;
    notifyListeners();
  }

  set setActiveTransactions(value) {
    _activeTransactions = value;
    notifyListeners();
  }
}
