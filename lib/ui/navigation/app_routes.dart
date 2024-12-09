import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart' as routemaster;
import 'package:taxigo_driver/domain/states/auth_state.dart';
import 'package:taxigo_driver/domain/states/home_state.dart';
import 'package:taxigo_driver/domain/states/mapkit_state.dart';
import 'package:taxigo_driver/domain/states/profile_state.dart';
import 'package:taxigo_driver/ui/navigation/page_transition.dart';
import 'package:taxigo_driver/ui/screens/account_screen.dart';
import 'package:taxigo_driver/ui/screens/earnings_screen.dart';
import 'package:taxigo_driver/ui/screens/home_screen.dart';
import 'package:taxigo_driver/ui/screens/navigationbar_screen.dart';
import 'package:taxigo_driver/ui/screens/ratings_screen.dart';
import 'package:taxigo_driver/ui/screens/signin_screen.dart';
import 'package:taxigo_driver/ui/screens/signup_screen.dart';
import 'package:taxigo_driver/ui/screens/vehicle_info_screen.dart';

class AppRoutes {
  static const signUp = '/sign-up';
  static const signIn = '$signUp/sign-in';

  static const vehicleInfo = '/vehicle-info';
  static const navigationBar = '/navigation-bar';
  static const home = '$navigationBar/home';
  static const earnings = '$navigationBar/earnings';
  static const ratings = '$navigationBar/ratings';
  static const account = '$navigationBar/account';

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
    onUnknownRoute: (_) => const routemaster.Redirect(navigationBar),
    routes: {
      vehicleInfo: (_) => TransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => ProfileState(),
              child: const VehicleInfoScreen(),
            ),
          ),
      navigationBar: (_) => routemaster.TabPage(
            paths: const [home, earnings, ratings, account],
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MapkitState()),
                ChangeNotifierProvider(create: (context) => HomeState(context)),
              ],
              child: const NavigationBarScreen(),
            ),
          ),
      home: (_) => const TransitionPage(child: HomeScreen()),
      earnings: (_) => const TransitionPage(child: EarningsScreen()),
      ratings: (_) => const TransitionPage(child: RatingsScreen()),
      account: (_) => const TransitionPage(child: AccountScreen()),
    },
  );
}
