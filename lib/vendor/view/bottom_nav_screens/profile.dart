import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/user/view/bottom_nav/bottom_nav.dart';
import 'package:smartico/vendor/view/authentication/vendor_sign_in.dart';

// ignore: must_be_immutable
class VendorProfile extends StatelessWidget {
  VendorProfile({super.key});

  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                await storage.delete(key: 'vendor_access_token');
                await storage.delete(key: 'vendorId');
                String? user = await storage.read(key: 'user_access_token');
                if(context.mounted){}
                if (user != null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const UserBottomNavBar(),
                      ),
                      (route) => false);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VendorSignIn(),
                      ),
                      (route) => false);
                }
              },
              child: const Text('signout'))),
    );
  }
}
