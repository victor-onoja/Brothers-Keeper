import 'package:brothers_keeper/features/home/viewsattach/homehome.dart';
import 'package:brothers_keeper/features/home/viewsattach/openissues.dart';
import 'package:brothers_keeper/features/marketplace/views/marketplace.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class HomePge extends StatefulWidget {
  const HomePge({super.key});

  @override
  State<HomePge> createState() => _HomePgeState();
}

class _HomePgeState extends State<HomePge> {
  final List<Widget> _screens = [
    const HomeHome(),
    const OpenIssues(),
    const MarketPlace()
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: AppColors.green.shade100,
              selectedItemColor: AppColors.bgcolor.shade400,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.web_rounded), label: 'Opened Issues'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.store_mall_directory),
                    label: 'MarketPlace'),
              ],
            )
          : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
                labelType: NavigationRailLabelType.all,
                selectedLabelTextStyle: Theme.of(context).textTheme.headline5,
                unselectedLabelTextStyle: Theme.of(context).textTheme.subtitle2,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.home), label: Text('Home')),
                  NavigationRailDestination(
                      icon: Icon(Icons.web_rounded),
                      label: Text('Opened Issues')),
                  NavigationRailDestination(
                      icon: Icon(Icons.store_mall_directory),
                      label: Text('MarketPlace')),
                ],
                selectedIndex: _selectedIndex),
          Expanded(
            child: _screens[_selectedIndex],
          )
        ],
      ),
    );
  }
}
