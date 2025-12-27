import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  void generatePdf(AppProvider appProvider) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("SRS Broiler Dispatch Report", style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 10),
            pw.Text("Driver: ${appProvider.driverName}"),
            pw.SizedBox(height: 10),
            pw.Text("Loading Entries:"),
            ...appProvider.loadingEntries.map((e) => pw.Text(
                "Empty: ${e.emptyWeight}, Load: ${e.loadWeight}, Net: ${e.netWeight}")),
            pw.SizedBox(height: 10),
            pw.Text("Unloading Customers:"),
            ...appProvider.unloadingCustomers.map((c) => pw.Text(
                "${c.name} - Boxes: ${c.boxes}, Load: ${c.loadWeight}, Net: ${c.netWeight}")),
            pw.SizedBox(height: 10),
            pw.Text("Stock Point:"),
            ...appProvider.unloadingStocks.map((s) => pw.Text(
                "${s.label} - Boxes: ${s.boxes}, Load: ${s.loadWeight}, Net: ${s.netWeight}")),
            pw.SizedBox(height: 10),
            pw.Text("Shrinkage / Loss: ${appProvider.shrinkage().toStringAsFixed(2)}")
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Summary Report")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Total Load Weight: ${appProvider.totalLoadWeight().toStringAsFixed(2)}"),
            Text("Total Customer Weight: ${appProvider.totalCustomerWeight().toStringAsFixed(2)}"),
            Text("Total Stock Weight: ${appProvider.totalStockWeight().toStringAsFixed(2)}"),
            Text("Shrinkage / Loss: ${appProvider.shrinkage().toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => generatePdf(appProvider),
              child: const Text("Export PDF / Print"),
            )
          ],
        ),
      ),
    );
  }
}