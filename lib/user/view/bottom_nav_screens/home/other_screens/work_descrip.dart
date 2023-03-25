import 'package:flutter/material.dart';

class ServiceDescriptionScrn extends StatelessWidget {
  const ServiceDescriptionScrn({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: width/1.1+30,
                width: width,
                child: const Image(
                  image: AssetImage(
                    'assets/splash/electrician 2.jpg',
                  ),
                  fit: BoxFit.cover,
                )),
            Card(
              elevation: 5.0,
                child: SizedBox(
              width: width,
              height: width,
            )),
            Padding(
              padding: const EdgeInsets.only(top: 7,right: 8,left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: width/7.5,
                    width: width/5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                            color: const Color.fromARGB(255, 123, 230, 219))),
                    child: const Icon(
                      Icons.message_rounded,
                      size: 30,
                      color: Color.fromARGB(255, 123, 230, 219),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 123, 230, 219),
                      padding:  EdgeInsets.symmetric(
                          horizontal: width/4, vertical:width/27),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
