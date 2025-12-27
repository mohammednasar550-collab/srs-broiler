import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/loading_entry.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final TextEditingController _emptyWeightController = TextEditingController();
  final TextEditingController _loadWeightController = TextEditingController();

  void addLoadingEntry() {
    double? emptyWeight = double.tryParse(_emptyWeightController.text);
    double? loadWeight = double.tryParse(_loadWeightController.text);

    if (emptyWeight == null || loadWeight == null) {
      Fluttertoast.showToast(msg: "Enter valid numbers");
      return;
    }

    final entry = LoadingEntry(emptyWeight: emptyWeight, loadWeight: loadWeight);
    Provider.of<AppProvider>(context, listen: false).addLoadingEntry(entry);

    _emptyWeightController.clear();
    _loadWeightController.clear();
    Fluttertoast.showToast(msg: "Loading entry added");
  }

  @override
  Widget build(BuildContext context) {
    final loadingEntries = Provider.of<AppProvider>(context).loadingEntries;

    return Scaffold(
      appBar: AppBar(title: const Text("Loading Bird Weight")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emptyWeightController,
              decoration: const InputDecoration(labelText: "Total Empty Weight"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _loadWeightController,
              decoration: const InputDecoration(labelText: "Total Load Weight"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: addLoadingEntry, child: const Text("Add Entry")),
            const SizedBox(height: 20),
            const Text("Entries Today:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: loadingEntries.length,
                itemBuilder: (context, index) {
                  final e = loadingEntries[index];
                  return ListTile(
                    title: Text("Net Weight: ${e.netWeight.toStringAsFixed(2)}"),
                    subtitle: Text("Empty: ${e.emptyWeight}, Load: ${e.loadWeight}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}