import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/Screens/AdFavorite/add_favorite.dart';

class AppBottomNavigation extends StatefulWidget {
  @override
  _AppBottomNavigationState createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  int _selectedIndex = 0;
  List<dynamic> menuItems = [
    {
      'icon': 'assets/icons/home.svg',
      'label': 'Home',
    },
    {
      'icon': 'assets/icons/favorite.svg',
      'label': 'Favorite',
    },
    {
      'icon': 'assets/icons/desk.svg',
      'label': 'Video',
    },
    {
      'icon': 'assets/icons/profile.svg',
      'label': 'Profile',
    },
    {
      'icon': 'assets/icons/sort.svg',
      'label': 'Refresh',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 1) {
      ///check if you have already set to favorite then go to edit favorite else go to add favorite ui
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => AddFavorite()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.black87,
      elevation: 32.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        height: 1.5,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        height: 1.5,
        fontSize: 12,
      ),
      items: menuItems.map((i) {
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(i['icon']),
          activeIcon: SvgPicture.asset(
            i['icon'],
            color: Colors.green[800],
          ),
          label: i['label'],
        );
      }).toList(),
      currentIndex: 0,
      selectedItemColor: Colors.green,
      onTap: _onItemTapped,
    );
  }
}
