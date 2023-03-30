import 'package:flutter/material.dart';
import 'package:smartico/user/view/bottom_nav_screens/account.dart';
import 'package:smartico/user/view/bottom_nav_screens/all_category.dart';
import 'package:smartico/user/view/bottom_nav_screens/chat/chats.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/user_home.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/dashboard.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/gigs_scrn.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/manage_orders.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/vendor_msg.dart';

class VendorBottomNavBar extends StatefulWidget {
  const VendorBottomNavBar({super.key});

  @override
  State<VendorBottomNavBar> createState() => _VendorBottomNavBarState();
}

class _VendorBottomNavBarState extends State<VendorBottomNavBar> {
  int currentIndex = 0;

  List bottomNavScreens = [
   const DashboardScrn(),
    const GigsScreen(),
    const VendorMsgScrn(),
    const ManageOrders(),
     ProfilePage()
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
        selectedItemColor: const Color.fromARGB(255, 52, 37, 168),
        unselectedItemColor: const Color.fromARGB(255, 149, 226, 218),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_outlined,
              ),
              label: 'Gigs Add'),
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
