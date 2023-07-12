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
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: currentIndex,
        selectedItemColor: const Color.fromARGB(255, 16, 81, 135),
        unselectedItemColor: Colors.black.withOpacity(0.3),
        items: [
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 22.0,
                  child: Icon(
                    color: Colors.black,
                    Icons.home,
                  ),
                ),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  // backgroundColor: Colors.transparent,
                  radius: 22.0,
                  child: Icon(
                    color: Colors.black,
                    Icons.category,
                  ),
                ),
              ),
              label: 'All'),
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 22.0,
                  child: Icon(
                    color: Colors.black,
                    Icons.chat,
                  ),
                ),
              ),
              label: 'Chat'),
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  // backgroundColor: Colors.transparent,
                  radius: 22.0,
                  child: Icon(
                    color: Colors.black,
                    Icons.book_online_outlined,
                  ),
                ),
              ),
              label: 'Booking'),
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  // backgroundColor: Colors.transparent,
                  radius: 22.0,
                  child: Icon(
                    color: Colors.black,
                    Icons.person_2_outlined,
                  ),
                ),
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
