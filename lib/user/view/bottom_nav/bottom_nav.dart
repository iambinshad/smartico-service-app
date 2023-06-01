import 'package:flutter/material.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/user/view/bottom_nav_screens/profile/user_profile.dart';
import 'package:smartico/user/view/bottom_nav_screens/all_cateogory/all_category.dart';
import 'package:smartico/user/view/bottom_nav_screens/booking_history/bookings.dart';
import 'package:smartico/user/view/bottom_nav_screens/chat/chats.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/user_home.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({super.key});

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  int currentIndex = 0;

  List bottomNavScreens = [
    UserHomePage(),
    AllCategroryList(),
    const UserChatScreen(),
    BookingHistory(),
    UserProfilePage()
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
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey.shade600,
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
              icon: Icon(Icons.book_online), label: 'Bookings'),
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
