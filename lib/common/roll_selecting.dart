import 'package:flutter/material.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/vendor/view/authentication/vendor_sign_in.dart';
import '../user/view/bottom_nav/bottom_nav.dart';

class RollSelectingScreen extends StatefulWidget {
  const RollSelectingScreen({super.key});

  @override
  State<RollSelectingScreen> createState() => _RollSelectingScreenState();
}

class _RollSelectingScreenState extends State<RollSelectingScreen> {
  bool customerCheckboxValue = false;
  bool serviceProviderCheckBoxValue = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Image(
            image: const AssetImage('assets/splash/logo3.webp'),
            height: width / 12,
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 123, 230, 219),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 23, left: 23),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight10,
                const Text(
                  'You are',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                kHeight10,
                const Text(
                  'Please select your role for this app',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                kHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: customerCheckboxValue,
                      onChanged: (value) {
                        setState(() {
                          customerCheckboxValue = !customerCheckboxValue;
                          serviceProviderCheckBoxValue = !customerCheckboxValue;
                        });
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    Text(
                      'Customer',
                      style: mediumText,
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/splash/customer.jpeg'),
                        fit: BoxFit.cover,
                      )),
                  width: width / 1,
                  height: width / 2,
                ),
                kHeight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: serviceProviderCheckBoxValue,
                      onChanged: (value) {
                        setState(() {
                          serviceProviderCheckBoxValue =
                              !serviceProviderCheckBoxValue;
                          customerCheckboxValue = !serviceProviderCheckBoxValue;
                        });
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    Text(
                      'Service Provider',
                      style: mediumText,
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image:
                            AssetImage('assets/splash/service provider.jpeg'),
                        fit: BoxFit.cover,
                      )),
                  width: width / 1,
                  height: width / 2,
                ),
                SizedBox(
                  height: width / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (customerCheckboxValue == true) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserBottomNavBar(),
                              ),
                              (route) => false);
                        } else if (serviceProviderCheckBoxValue == true) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VendorSignIn(),
                              ),
                              (route) => false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 4, vertical: width / 27),
                        backgroundColor:
                            const Color.fromARGB(255, 123, 230, 219),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
