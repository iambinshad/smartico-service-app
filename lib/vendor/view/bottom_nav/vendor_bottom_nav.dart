import 'package:flutter/material.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/gigs/gigs_scrn.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/bookings_tabs/tab_bar.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/chats/chats.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/profile.dart';

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
     const ManageOrdersTab(),
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
        selectedItemColor: Colors.black,
        unselectedItemColor:mainColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_outlined,
              ),
              label: 'Add Gig'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message_rounded,
              ),
              label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.book_online,
              ),
              label: 'Manage Order'),
              BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
