import 'package:flutter/material.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/bookings/all_bookings.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/gigs/gigs_scrn.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/chats/chats.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/profile/profile.dart';

class VendorBottomNavBar extends StatefulWidget {
  const VendorBottomNavBar({super.key});

  @override
  State<VendorBottomNavBar> createState() => _VendorBottomNavBarState();
}

class _VendorBottomNavBarState extends State<VendorBottomNavBar> {
  int currentIndex = 0;

  List bottomNavScreens = [
    const GigsScreen(),
    VendorChatScrn(),
    const AllBookingTab(),
    VendorProfile()
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
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        selectedItemColor: const Color.fromARGB(255, 16, 81, 135),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 22.0,
                  child: Icon(
                    Icons.category,
                  ),
                ),
              ),
              label: 'Add Gigs'),
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 22.0,
                  child: Icon(
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
                  radius: 22.0,
                  child: Icon(
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
                  radius: 22.0,
                  child: Icon(
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
