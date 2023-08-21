import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const String id = "main";

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("TAXIGO-DRIVER"),
      ),
    );
  }
}
