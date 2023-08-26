import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxigo_driver/ui/screens/account_screen.dart';
import 'package:taxigo_driver/ui/screens/earnings_screen.dart';
import 'package:taxigo_driver/ui/screens/home_screen.dart';
import 'package:taxigo_driver/ui/screens/ratings_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _index = 0;
  final _screens = [
    const HomeScreen(),
    const EarningsScreen(),
    const RatingsScreen(),
    const AccountScreen(),
  ];
  final _titles = ['Home', 'Earnings', 'Ratings', 'Account'];
  final _materialIcons = [
    const Icon(Icons.home),
    const Icon(CupertinoIcons.creditcard_fill),
    const Icon(Icons.star),
    const Icon(Icons.person),
  ];
  final _cupertinoIcons = [
    const Icon(CupertinoIcons.home),
    const Icon(CupertinoIcons.creditcard),
    const Icon(CupertinoIcons.star),
    const Icon(CupertinoIcons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (int i) => setState(() => _index = i),
        destinations: [
          for (int i = 0; i < _screens.length; i++)
            NavigationDestination(
              icon:
                  !Platform.isAndroid ? _materialIcons[i] : _cupertinoIcons[i],
              label: _titles[i],
            ),
        ],
      ),
    );
  }
}
