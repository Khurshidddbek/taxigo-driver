import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:taxigo_driver/ui/screens/home_screen.dart';
import 'package:taxigo_driver/ui/utils/toast_util.dart';

class ProfileState with ChangeNotifier {
  // Variables -----------------------------------------------------------------

  final _formKey = GlobalKey<FormState>();
  final _modelController = TextEditingController();
  final _colorController = TextEditingController();
  final _carNumberController = TextEditingController();

  // Getters -------------------------------------------------------------------

  GlobalKey get formKey => _formKey;
  TextEditingController get modelController => _modelController;
  TextEditingController get colorController => _colorController;
  TextEditingController get carNumberController => _carNumberController;

  // Methods -------------------------------------------------------------------

  String? simpleValidator(String? value) {
    if (value != null && (value.isNotEmpty || value.length > 3)) {
      return null;
    }
    return "Please, provide a valid info";
  }

  void updateVehicleInfo(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    try {
      if (context.mounted) {
        _apiPutVehicleInfo();
      }
    } catch (e) {
      ToastUtil.showSnackbar(context, e.toString());
      return;
    }

    // Navigate
    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
  }

  // APIs ----------------------------------------------------------------------

  Future<void> _apiPutVehicleInfo() async {
    DatabaseReference newUserRef = FirebaseDatabase.instance.ref().child(
        "drivers/${FirebaseAuth.instance.currentUser!.uid}/vehicle_details");

    // Prepare data to be saved on users table
    Map vehicleInfo = {
      "car_model": _modelController.text,
      "_car_color": _colorController.text,
      "vehicle_number": _carNumberController.text,
    };

    await newUserRef.set(vehicleInfo);
  }
}
