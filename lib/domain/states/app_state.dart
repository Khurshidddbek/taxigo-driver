import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:taxigo_driver/ui/navigation/routes.dart';

class AppState extends ChangeNotifier {
  late bool _isLoggedIn;
  RouteMap _currentRoute = AppRoutes.loggedOutMap;

  AppState() {
    _isLoggedIn = FirebaseAuth.instance.currentUser != null;
    onChangeRoute();
  }

  // Getters -------------------------------------------------------------------

  RouteMap get currentRoute => _currentRoute;

  // Methods -------------------------------------------------------------------

  void onChangeRoute({RouteMap? route}) {
    _currentRoute =
        route ?? (_isLoggedIn ? AppRoutes.loggedInMap : AppRoutes.loggedOutMap);
    notifyListeners();
  }
}
