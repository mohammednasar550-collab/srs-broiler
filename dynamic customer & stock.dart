import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/unloading_customer.dart';
import '../models/unloading_stock.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UnloadingScreen extends StatefulWidget {
  const UnloadingScreen({super.key});

  @override
  State<UnloadingScreen> createState() => _UnloadingScreenState();
}

class _UnloadingScreenState extends State<UnloadingScreen> {
  final List<UnloadingCustomer> customers = [];
  final List<UnloadingStock> stocks = [];

  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerBoxesController = TextEditingController();
  final TextEditingController _customerLoadController = TextEditingController();
  final TextEditingController _customerEmptyController = TextEditingController();

  final TextEditingController _stockLabelController = TextEditingController();
  final TextEditingController _stockBoxesController = TextEditingController();
  final TextEditingController _stockLoadController = TextEditingController();
  final TextEditingController _stockEmptyController = TextEditingController();

  void addCustomer() {
    String name = _customerNameController.text;
    int? boxes = int.tryParse(_customerBoxesController.text);
    double? load = double.tryParse(_customerLoadController.text);
    double? empty = double.tryParse(_customerEmptyController.text);

    if (name.isEmpty || boxes == null || load == null || empty == null) {
      Fluttertoast.showToast(msg: "Enter valid customer data");
      return;
    }

    final customer = UnloadingCustomer(
        name: name, boxes: boxes, loadWeight: load, emptyWeight: empty);

    Provider.of<AppProvider>(context, listen: false).addUnloadingCustomer(customer);

    _customerNameController.clear();
    _customerBoxesController.clear();
    _customerLoadController.clear();
    _customerEmptyController.clear();
    Fluttertoast.showToast(msg: "Customer added");
  }

  void addStock() {
    String label = _stockLabelController.text;
    int? boxes = int.tryParse(_stockBoxesController.text);
    double? load = double.tryParse(_stockLoadController.text);
    double? empty = double.tryParse(_stockEmptyController.text);

    if (label.isEmpty || boxes == null || load == null || empty == null) {
      Fluttertoast.showToast(msg: "Enter valid stock data");
      return;
    }

    final stock = UnloadingStock(
        label: label, boxes: boxes, loadWeight: load, emptyWeight: empty);

    Provider.of<AppProvider>(context, listen: false).addUnloadingStock(stock);

    _stockLabelController.clear();
    _stockBoxesController.clear();
    _stockLoadController.clear();
    _stockEmptyController.clear();
    Fluttertoast.showToast(msg: "Stock added");
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Unloading Bird Weight")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Customers", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _customerNameController, decoration: const InputDecoration(labelText: "Customer Name")),
            TextField(controller: _customerBoxesController, decoration: const InputDecoration(labelText: "No of Boxes"), keyboardType: TextInputType.number),
            TextField(controller: _customerLoadController, decoration: const InputDecoration(labelText: "Load Weight"), keyboardType: TextInputType.number),
            TextField(controller: _customerEmptyController, decoration: const InputDecoration(labelText: "Empty Weight"), keyboardType: TextInputType.number),
            ElevatedButton(onPressed: addCustomer, child: const Text("Add Customer")),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appProvider.unloadingCustomers.length,
              itemBuilder: (context, index) {
                final c = appProvider.unloadingCustomers[index];
                return ListTile(
                  title: Text("${c.name} - Net: ${c.netWeight.toStringAsFixed(2)}"),
                  subtitle: Text("Boxes: ${c.boxes}, Load: ${c.loadWeight}, Empty: ${c.emptyWeight}"),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text("Stock Point", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _stockLabelController, decoration: const InputDecoration(labelText: "Stock Label")),
            TextField(controller: _stockBoxesController, decoration: const InputDecoration(labelText: "No of Boxes"), keyboardType: TextInputType.number),
            TextField(controller: _stockLoadController, decoration: const InputDecoration(labelText: "Load Weight"), keyboardType: TextInputType.number),
            TextField(controller: _stockEmptyController, decoration: const InputDecoration(labelText: "Empty Weight"), keyboardType: TextInputType.number),
            ElevatedButton(onPressed: addStock, child: const Text("Add Stock")),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appProvider.unloadingStocks.length,
              itemBuilder: (context, index) {
                final s = appProvider.unloadingStocks[index];
                return ListTile(
                  title: Text("${s.label} - Net: ${s.netWeight.toStringAsFixed(2)}"),
                  subtitle: Text("Boxes: ${s.boxes}, Load: ${s.loadWeight}, Empty: ${s.emptyWeight}"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}