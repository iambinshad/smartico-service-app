import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/authentication/user_sign_in.dart';
import 'package:smartico/vendor/view/authentication/vendor_sign_in.dart';
import 'package:smartico/vendor/view/bottom_nav/vendor_bottom_nav.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 23, left: 23),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight10,
              const Text(
                'You are ?',
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
              InkWell(
                onTap: () {
                  setState(() {
                    customerCheckboxValue = !customerCheckboxValue;
                    serviceProviderCheckBoxValue = !customerCheckboxValue;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/splash/customer.jpeg'),
                        fit: BoxFit.cover,
                      )),
                  width: width / 1,
                  height: width / 2,
                ),
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
              InkWell(
                onTap: () {
                  setState(() {
                    serviceProviderCheckBoxValue =
                        !serviceProviderCheckBoxValue;
                    customerCheckboxValue = !serviceProviderCheckBoxValue;
                  });
                },
                child: Container(
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
              ),
              SizedBox(
                height: width / 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      FlutterSecureStorage storage = const FlutterSecureStorage();

                      if (customerCheckboxValue == true) {
                        final userAccessToken =
                            await storage.read(key: 'user_access_token');

                        if (userAccessToken != null) {
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UserBottomNavBar(),
                                ),
                                (route) => false);
                          }
                        } else {
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserSignIn(),
                                ),
                                (route) => false);
                          }
                        }
                      } else if (serviceProviderCheckBoxValue == true) {
                        final userAccessToken =
                            await storage.read(key: 'vendor_access_token');

                        if (userAccessToken != null) {
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const VendorBottomNavBar(),
                                ),
                                (route) => false);
                          }
                        } else {
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VendorSignIn(),
                                ),
                                (route) => false);
                          }
                        }
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
    );
  }
}
