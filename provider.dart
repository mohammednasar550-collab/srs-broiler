import 'package:flutter/material.dart';
import '../models/loading_entry.dart';
import '../models/unloading_customer.dart';
import '../models/unloading_stock.dart';

class AppProvider extends ChangeNotifier {
  String? driverName;

  List<LoadingEntry> loadingEntries = [];
  List<UnloadingCustomer> unloadingCustomers = [];
  List<UnloadingStock> unloadingStocks = [];

  void login(String username) {
    driverName = username;
    notifyListeners();
  }

  void addLoadingEntry(LoadingEntry entry) {
    loadingEntries.add(entry);
    notifyListeners();
  }

  void addUnloadingCustomer(UnloadingCustomer customer) {
    unloadingCustomers.add(customer);
    notifyListeners();
  }

  void addUnloadingStock(UnloadingStock stock) {
    unloadingStocks.add(stock);
    notifyListeners();
  }

  double totalLoadWeight() => loadingEntries.fold(0, (sum, e) => sum + e.loadWeight);

  double totalCustomerWeight() => unloadingCustomers.fold(0, (sum, c) => sum + c.loadWeight);

  double totalStockWeight() => unloadingStocks.fold(0, (sum, s) => sum + s.loadWeight);

  double shrinkage() => (totalCustomerWeight() + totalStockWeight()) - totalLoadWeight();
}