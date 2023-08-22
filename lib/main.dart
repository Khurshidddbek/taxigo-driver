import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taxigo_driver/firebase_options.dart';
import 'package:taxigo_driver/ui/screens/main_screen.dart';

void main() async {
  // Firebase init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TAXIGO-DRIVER',
      theme: ThemeData(
        fontFamily: "Brand-Regular",
      ),
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => const MainScreen(),
      },
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
