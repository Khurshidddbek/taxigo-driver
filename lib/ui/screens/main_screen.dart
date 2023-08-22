import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:taxigo_driver/ui/widgets/taxi_button.dart';

class MainScreen extends StatelessWidget {
  static const String id = "main";

  const MainScreen({super.key});

  void _testConnection() async {
    // Create a new record in the database
    FirebaseDatabase.instance
        .ref()
        .child("testing")
        .push()
        .set({"connection": "successful"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TaxiButton(
            title: "CONNECTION TESTING",
            color: Colors.blue,
            onPressed: _testConnection,
          ),
        ),
      ),
    );
  }
}
