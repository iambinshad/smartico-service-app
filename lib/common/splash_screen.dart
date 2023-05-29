import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/user/view/authentication/user_sign_in.dart';
import 'package:smartico/user/view/bottom_nav/bottom_nav.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      

      moveToNextPage(context);
    });
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage(
            'assets/splash/logo3.webp',
          ),
          width: kIsWeb ? 400 : 300,
          height: kIsWeb ? 280 : 180,
        ),
      ),
    );
  }

  Future<void> moveToNextPage(context) async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final storageTokenData = await storage.read(key: 'user_access_token');
    log(storageTokenData.toString());
    if (storageTokenData != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const UserBottomNavBar(),
          ),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => UserSignIn(),
          ),
          (route) => false);
    }
  }
}
