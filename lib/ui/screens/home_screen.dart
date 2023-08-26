import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxigo_driver/domain/states/mapkit_state.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<MapkitState>();
    final state = context.watch<MapkitState>();

    return Scaffold(
      body: Center(
        child: YandexMap(
          onMapCreated: (controller) {
            if (!read.mapControllerCompleter.isCompleted) {
              read.mapControllerCompleter.complete(controller);
            }
          },
          mapObjects: state.mapObjects,
          mapMode: MapMode.driving,
          logoAlignment: const MapAlignment(
            horizontal: HorizontalAlignment.left,
            vertical: VerticalAlignment.bottom,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => !state.isLocationLoading ? read.init() : {},
        backgroundColor: CupertinoColors.systemGrey5,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
          child: !state.isLocationLoading
              ? const Icon(
                  Icons.my_location_outlined,
                  color: Colors.black,
                )
              : const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator.adaptive(),
                ),
        ),
      ),
    );
  }
}
