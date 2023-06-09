import 'package:flutter/material.dart';
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
        selectedItemColor: const Color.fromARGB(255, 16, 81, 135),
        unselectedItemColor: Colors.black.withOpacity(0.3),
        items: const [
          BottomNavigationBarItem(
              icon: CircleAvatar(
                  child: Icon(
                Icons.home_filled,
                color: Colors.black,
              )),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                child: Icon(
                  color: Colors.black,
                  Icons.category,
                ),
              ),
              label: 'All'),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  color: Colors.black,
                  Icons.chat_outlined,
                ),
              ),
              label: 'Chat'),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                  child: Icon(
                Icons.book_online,
                color: Colors.black,
              )),
              label: 'Bookings'),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                child: Icon(
                  color: Colors.black,
                  Icons.person,
                ),
              ),
              label: 'profile'),
        ],
      ),
    );
  }
}
