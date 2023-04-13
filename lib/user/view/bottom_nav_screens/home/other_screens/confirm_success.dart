import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/bottom_nav/bottom_nav.dart';

class BookingStatus extends StatelessWidget {
  const BookingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Have any questions? Reach directly to our Customer Support'),
        ],
      ),
      body: Column(
        children: [
          kHeight40,
          Center(
            child: Image(
                image:
                    AssetImage('assets/user_home/59945-success-confetti.gif')),
          ),
          Text(
            'Booking Confirmed!',
            style: GoogleFonts.publicSans(
                fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your booking has been placed successfully.',
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Booking History',
                    style: TextStyle(color: mainColor),
                  ))
            ],
          ),
          kHeight20,
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => UserBottomNavBar()),
                  (Route<dynamic> route) => false);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    5), // Set the border radius to 0 to create a square button
              ),
              elevation: 3, // Set the elevation of the button
              backgroundColor: Colors
                  .green.shade400, // Set the background color of the button
            ),
            child: const Text(
              'Back To Home',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
