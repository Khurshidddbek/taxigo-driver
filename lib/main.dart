import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxigo_driver/domain/states/auth_state.dart';
import 'package:taxigo_driver/domain/states/profile_state.dart';
import 'package:taxigo_driver/firebase_options.dart';
import 'package:taxigo_driver/ui/screens/main_screen.dart';
import 'package:taxigo_driver/ui/screens/signin_screen.dart';
import 'package:taxigo_driver/ui/screens/signup_screen.dart';
import 'package:taxigo_driver/ui/screens/vehicle_info_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        ChangeNotifierProvider(create: (_) => ProfileState()),
      ],
      child: MaterialApp(
        title: 'TAXIGO-DRIVER',
        theme: ThemeData(
          fontFamily: "Brand-Regular",
        ),
        initialRoute: SignUpScreen.id,
        routes: {
          SignUpScreen.id: (context) => const SignUpScreen(),
          SignInScreen.id: (context) => const SignInScreen(),
          MainScreen.id: (context) => const MainScreen(),
          VehicleInfoScreen.id: (context) => const VehicleInfoScreen(),
        },
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
