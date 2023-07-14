import 'dart:async';
import 'dart:developer';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/common/roll_selecting.dart';
import 'package:smartico/user/view/authentication/user_sign_in.dart';
import 'package:smartico/user/view/bottom_nav/bottom_nav.dart';
import 'package:smartico/vendor/view/bottom_nav/vendor_bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription subscription;

  var isDeviceConnected = false;

  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
       final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      moveToNextPage(context);
    });
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(10)),
                  height: height / 13,
                  width: width / 2,
                  child: const Center(
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        'assets/splash/newLogo.png',
                      ),
                      height: 70,
                      width: 200,
                    ),
                  ),
                ),
      ),
    );
  }

  Future<void> moveToNextPage(context) async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final userAccessToken = await storage.read(key: 'user_access_token');
    final vendorAccessToken = await storage.read(key: 'vendor_access_token');
    log(userAccessToken.toString());
    log(vendorAccessToken.toString());
    if (userAccessToken == null && vendorAccessToken == null ||
        userAccessToken != null && vendorAccessToken != null && isDeviceConnected) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const RollSelectingScreen(),
          ),
          (route) => false);
    } else if (userAccessToken != null && vendorAccessToken == null && isDeviceConnected) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const UserBottomNavBar(),
          ),
          (route) => false);
    } else if (userAccessToken == null && vendorAccessToken != null && isDeviceConnected) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const VendorBottomNavBar(),
          ),
          (route) => false);
    }else{
      showDialogBox();
    }
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;

      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogBox() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("No Connection"),
        content: const Text("Please check your internet connectivity"),
        actions: <Widget>[
          TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() {
                  isAlertSet = false;
                });
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: const Text('OK'))
        ],
      ),
    );
  }
}
