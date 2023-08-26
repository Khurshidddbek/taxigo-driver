import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart' as routemaster;
import 'package:taxigo_driver/domain/states/auth_state.dart';
import 'package:taxigo_driver/domain/states/profile_state.dart';
import 'package:taxigo_driver/ui/navigation/page_transition.dart';
import 'package:taxigo_driver/ui/screens/home_screen.dart';
import 'package:taxigo_driver/ui/screens/signin_screen.dart';
import 'package:taxigo_driver/ui/screens/signup_screen.dart';
import 'package:taxigo_driver/ui/screens/vehicle_info_screen.dart';

class AppRoutes {
  static const signUp = '/sign-up';
  static const signIn = '$signUp/sign-in';

  static const vehicleInfo = '/vehicle-info';
  static const home = '/home';

  static final loggedOutMap = routemaster.RouteMap(
    onUnknownRoute: (_) => const routemaster.Redirect(signUp),
    routes: {
      signUp: (_) => TransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => AuthState(),
              child: const SignUpScreen(),
            ),
          ),
      signIn: (_) => TransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => AuthState(),
              child: const SignInScreen(),
            ),
          ),
    },
  );

  static final loggedInMap = routemaster.RouteMap(
    onUnknownRoute: (_) => const routemaster.Redirect(home),
    routes: {
      vehicleInfo: (_) => TransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => ProfileState(),
              child: const VehicleInfoScreen(),
            ),
          ),
      home: (_) => const TransitionPage(
            child: HomeScreen(),
          ),
    },
  );
}
