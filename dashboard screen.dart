import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'unloading_screen.dart';
import 'summary_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const LoadingScreen()));
                },
                child: const Text("Enter Loading Bird Weight")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UnloadingScreen()));
                },
                child: const Text("Enter Unloading Bird Weight")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SummaryScreen()));
                },
                child: const Text("Summary Report")),
          ],
        ),
      ),
    );
  }
}