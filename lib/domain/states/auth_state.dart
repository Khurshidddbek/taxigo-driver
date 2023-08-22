import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:taxigo_driver/ui/screens/main_screen.dart';
import 'package:taxigo_driver/ui/widgets/progress_dialog.dart';

class AuthState with ChangeNotifier {
  // Variables -----------------------------------------------------------------

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // Getters -------------------------------------------------------------------

  GlobalKey get formKey => _formKey;
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get passwordController => _passwordController;

  // Methods (Validators) ------------------------------------------------------

  String? validateName(String? value) {
    if (value != null && (value.isNotEmpty || value.length > 3)) {
      return null;
    }
    return "Please, provide a valid full name";
  }

  String? validateEmail(String? value) {
    if (value != null &&
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return null;
    }
    return "Please, provide a valid email";
  }

  String? validatePhone(String? value) {
    if (value != null && RegExp(r"^\+?[0-9]{10,}$").hasMatch(value)) {
      return null;
    }
    return "Please, provide a valid phone number";
  }

  String? validatePassword(String? value) {
    if (value != null && value.length >= 8) {
      return null;
    }
    return "Please, provide a valid password";
  }

  // Methods (Dialogs)----------------------------------------------------------

  void _showSnackbar(BuildContext context, String? text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(text ?? "")),
    ));
  }

  void _showDialog(BuildContext context, String text) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => ProgressDialog(status: text),
      );

  void _closeDialog(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pop();

  // Methods -------------------------------------------------------------------

  void signUp(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    // check internet connection
    if (!(await hasInternetConnection())) {
      if (context.mounted) {
        _showSnackbar(context, "Please, check your internet connection");
      }
    }

    if (context.mounted) {
      _apiSignUp(context);
    }
  }

  Future<bool> hasInternetConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }

  // APIs ----------------------------------------------------------------------

  void _apiSignUp(BuildContext context) async {
    _showDialog(context, "Registering you...");

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      if (FirebaseAuth.instance.currentUser != null) {
        await _apiPutUserInfo();
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        _showSnackbar(context, e.message);
      }
      return;
    } finally {
      if (context.mounted) {
        _closeDialog(context);
      }
    }

    // Navigate to main page
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.id, (route) => false);
    }
  }

  Future<void> _apiPutUserInfo() async {
    DatabaseReference newUserRef = FirebaseDatabase.instance
        .ref()
        .child("drivers/${FirebaseAuth.instance.currentUser!.uid}");

    // Prepare data to be saved on users table
    Map userMap = {
      "fullname": _nameController.text,
      "email": emailController.text,
      "phone": _phoneController.text,
    };

    await newUserRef.set(userMap);
  }
}
