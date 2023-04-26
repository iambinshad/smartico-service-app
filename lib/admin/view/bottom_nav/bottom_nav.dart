import 'package:flutter/material.dart';
import 'package:smartico/admin/view/admin_home_page.dart';
import 'package:smartico/admin/view/bottom_nav/bottom_nav_screens/all_vendors_screen.dart';

class AdminBottonNavBar extends StatefulWidget {
   const AdminBottonNavBar({super.key});

  @override
  State<AdminBottonNavBar> createState() => _AdminBottonNavBarState();
}

class _AdminBottonNavBarState extends State<AdminBottonNavBar> {
  List screens = [
    AdminPage(),
    const AllVendorForAdmin(),

  ];

int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: screens[currentIndex],

     bottomNavigationBar: BottomNavigationBar(items:const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),

      BottomNavigationBarItem(icon: Icon(Icons.workspaces_sharp),label: 'All Vendors')

     ],currentIndex: currentIndex,onTap: (value) {
       setState((){
        currentIndex = value;
        
       });
     },),
    );
  }
}