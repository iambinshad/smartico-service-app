import 'package:flutter/material.dart';
import 'package:smartico/core/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Card(
              child: Text(
                  """Welcome to Smartico App , Our service provider application is the ultimate tool for connecting customers with the services they need, and service providers with the customers they want. Our platform simplifies the entire process, from scheduling to payment, to ensure a seamless and hassle-free experience for everyone involved. With advanced features like real-time chat, appointment reminders, and detailed job histories, our application takes customer service to the next level. Whether you're a service provider looking to expand your business or a customer in need of reliable services, our application has you covered.""", style: TextStyle(
                fontFamily: 'poppins', fontSize: 16, color: Colors.black),),
            )
          ],
        ),
      ),
    );
  }
}
