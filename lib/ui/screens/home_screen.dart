import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxigo_driver/domain/states/home_state.dart';
import 'package:taxigo_driver/domain/states/mapkit_state.dart';
import 'package:taxigo_driver/ui/theme/app_colors.dart';
import 'package:taxigo_driver/ui/widgets/taxi_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final readMapkit = context.read<MapkitState>();
    final stateMapkit = context.watch<MapkitState>();
    final readHome = context.read<HomeState>();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // #button
            Container(
              height: 135,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 35),
              color: AppColors.primary,
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 238,
                  child: TaxiButton(
                    title: "GO ONLINE",
                    style:
                        const TextStyle(fontSize: 20, fontFamily: 'Brand-Bold'),
                    color: AppColors.orange,
                    onPressed: () => readHome.goOnline(),
                  ),
                ),
              ),
            ),

            // #map
            Expanded(
              child: YandexMap(
                onMapCreated: (controller) {
                  if (!readMapkit.mapControllerCompleter.isCompleted) {
                    readMapkit.mapControllerCompleter.complete(controller);
                  }
                },
                mapObjects: stateMapkit.mapObjects,
                mapMode: MapMode.driving,
                logoAlignment: const MapAlignment(
                  horizontal: HorizontalAlignment.left,
                  vertical: VerticalAlignment.bottom,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            !stateMapkit.isLocationLoading ? readMapkit.init() : {},
        backgroundColor: CupertinoColors.systemGrey5,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
          child: !stateMapkit.isLocationLoading
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
