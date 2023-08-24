import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:taxigo_driver/domain/states/app_state.dart';
import 'package:taxigo_driver/firebase_options.dart';
import 'package:taxigo_driver/ui/navigation/route_observer.dart';

final routemaster = RoutemasterDelegate(
  observers: [MyRouteObserver()],
  routesBuilder: (context) {
    final appState = context.watch<AppState>();
    return appState.currentRoute;
  },
);

void main() async {
  // Firebase init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp.router(
        routerDelegate: routemaster,
        routeInformationParser: const RoutemasterParser(),
        title: 'TAXIGO-DRIVER',
        theme: ThemeData(fontFamily: "Brand-Regular"),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }
}
