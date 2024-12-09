import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxigo_driver/domain/models/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapkitState extends ChangeNotifier {
  bool _isLocationLoading = false;
  final _mapControllerCompleter = Completer<YandexMapController>();
  final List<MapObject> _mapObjects = [];

  final Location _defaultLocation =
      Location(latitude: 41.311081, longitude: 69.240562);
  Location? _currentLocation;

  MapkitState() {
    init();
  }

  Future<void> init() async {
    isLocationLoading = true;
    await _initPermission();
    _currentLocation = await fetchCurrentLocation();
    await _moveCamerTo(_currentLocation!);
    await _addCurrentLocationToMap(beforeDelay: 2);
    isLocationLoading = false;
  }

  // Getters -------------------------------------------------------------------

  Completer<YandexMapController> get mapControllerCompleter =>
      _mapControllerCompleter;
  List<MapObject> get mapObjects => _mapObjects;
  bool get isLocationLoading => _isLocationLoading;
  Location? get currentLocation => _currentLocation;

  // Setters -------------------------------------------------------------------

  set isLocationLoading(bool value) {
    _isLocationLoading = value;
    notifyListeners();
  }

  // Permission methods --------------------------------------------------------

  Future<bool> _checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((e) {
      debugPrint("Error: checkPermission().checkPermission(): $e");
      return false;
    });
  }

  Future<bool> _requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((e) {
      debugPrint("Error: requestPermission().requestPermission(): $e");
      return false;
    });
  }

  Future<void> _initPermission() async {
    if (!await _checkPermission()) {
      await _requestPermission();
    }
  }

  // Location methods ----------------------------------------------------------

  Future<Location> fetchCurrentLocation() async {
    isLocationLoading = true;

    _currentLocation = await Geolocator.getCurrentPosition().then((value) {
      return Location(latitude: value.latitude, longitude: value.longitude);
    }).catchError((e) {
      debugPrint("Error: getCurrentLocation().getCurrentLocation(): $e");
    });
    isLocationLoading = false;
    return _defaultLocation;
  }

  Future<void> _moveCamerTo(Location location) async {
    (await _mapControllerCompleter.future).moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location.toPoint,
          zoom: 15,
        ),
      ),
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2),
    );
  }

  // #TODO: refactoring: create a method to add a marker to the map
  Future<void> _addCurrentLocationToMap({double beforeDelay = 0}) async {
    await Future.delayed(Duration(milliseconds: (beforeDelay * 1000).toInt()));

    mapObjects.add(
      PlacemarkMapObject(
        mapId: const MapObjectId("current-location"),
        point: _currentLocation!.toPoint,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            scale: 3,
            image:
                BitmapDescriptor.fromAssetImage('assets/images/pickicon.png'),
          ),
        ),
      ),
    );
    notifyListeners();
  }
}
