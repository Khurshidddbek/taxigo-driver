import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YandexMap(
          onMapCreated: (controller) =>
              Completer<YandexMapController>().complete(controller),
        ),
      ),
    );
  }
}
