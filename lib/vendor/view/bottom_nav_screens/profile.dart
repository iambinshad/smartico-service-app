import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/vendor/view/authentication/vendor_sign_in.dart';

// ignore: must_be_immutable
class VendorProfile extends StatelessWidget {
   VendorProfile({super.key});

FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(),
      body: Center(child:ElevatedButton(onPressed: ()async{
        await storage.delete(key: 'vendor_access_token');
        await storage.delete(key: 'vendorId');
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VendorSignIn(),), (route) => false);
      }, child: const Text('signout'))),
    );
  }
}