import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
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
