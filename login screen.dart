import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'dashboard_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void login() {
    if (_username.text.isEmpty || _password.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter username & password");
      return;
    }

    // Simple login (for prototype)
    Provider.of<AppProvider>(context, listen: false).login(_username.text);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SRS Broiler", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              TextField(controller: _username, decoration: const InputDecoration(labelText: "Username")),
              const SizedBox(height: 10),
              TextField(controller: _password, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: login, child: const Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}