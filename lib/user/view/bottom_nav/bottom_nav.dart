import 'package:flutter/material.dart';
import 'package:smartico/user/view/bottom_nav_screens/account.dart';
import 'package:smartico/user/view/bottom_nav_screens/all_category.dart';
import 'package:smartico/user/view/bottom_nav_screens/chat_screen.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/user_home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  List bottomNavScreens = [
   const UserHomePage(),
    AllCategroryList(),
   const ChatScreen(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.shifting,
        elevation: 20.0,
        currentIndex: currentIndex,
        selectedItemColor: Color.fromARGB(255, 52, 37, 168),
        unselectedItemColor: Color.fromARGB(255, 149, 226, 218),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
              label: 'All'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_outlined,
              ),
              label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'profile'),
        ],
      ),
    );
  }
}
