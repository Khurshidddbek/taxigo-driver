import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:provider/provider.dart';
import 'package:taxigo_driver/domain/models/location.dart';
import 'package:taxigo_driver/domain/states/mapkit_state.dart';

class HomeState extends ChangeNotifier {
  BuildContext context;

  HomeState(this.context);
  // Methods -------------------------------------------------------------------

  void goOnline() async {
    final read = context.read<MapkitState>();
    Location location =
        read.currentLocation ?? await read.fetchCurrentLocation();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String pathToReference = "AvailableDrivers";

    await Geofire.initialize(pathToReference);
    await Geofire.setLocation(uid, location.latitude, location.longitude);

    DatabaseReference tripRequestRef =
        FirebaseDatabase.instance.ref().child('drivers/$uid/newtrip');
    tripRequestRef.set('waiting');

    tripRequestRef.onValue.listen((event) {});
  }
}
