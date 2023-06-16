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
        selectedItemColor: const Color.fromARGB(255, 16, 81, 135),
        unselectedItemColor:Colors.grey,
        items:  [
           BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 16, 81, 135),
                    width: 2.0,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 22.0,
                  child: Icon(
                    color: Colors.black,
                    Icons.category,
                  ),
                ),
              ),
              label: 'Add Gigs'),
          BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 16, 81, 135),
                    width: 2.0,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 16, 81, 135),
                    width: 2.0,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 16, 81, 135),
                    width: 2.0,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
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
