import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/all_booking/all_bookings.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/bookings_tabs/tabs/all_bookings.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/bookings_tabs/tabs/completed_bookings.dart';

class ManageOrdersTab extends StatefulWidget {
   const ManageOrdersTab({super.key});

  @override
  State<ManageOrdersTab> createState() => _ManageOrdersTabState();
}

class _ManageOrdersTabState extends State<ManageOrdersTab> with SingleTickerProviderStateMixin{
@override
  void initState() {
     tabController = TabController(length: 2, vsync:this);
    super.initState();
  }
    @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
 late TabController tabController;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AllBookingProvider>(context, listen: false)
          .fetchAllBookings(context);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Bookings',),backgroundColor:mainColor,centerTitle: true,bottom:
        TabBar(
        controller:tabController ,
        tabs:const [
        Tab(text: 'All Bookings',),
            Tab(text: 'Completed Bookings',),
            
       ]),),
      body: TabBarView(
        controller: tabController,
        
        children:const[
        AllBookingTab(),
  CompletedBookingsTab()
      ] )
    );
  }
}
