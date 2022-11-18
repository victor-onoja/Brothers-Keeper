import 'package:brothers_keeper/core/constants/colors.dart';
import 'package:brothers_keeper/features/marketplace/viewsattach/marketplacewidget.dart';
import 'package:brothers_keeper/features/marketplace/viewsattach/marketplacewidget2.dart';
import 'package:flutter/material.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final List<Widget> _screens = [const MPH(), const MPW()];
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
                    icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
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
                      icon: Icon(Icons.account_balance_wallet),
                      label: Text('Wallet')),
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
