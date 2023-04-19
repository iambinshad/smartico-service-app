import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/vendor/view/authentication/vendor_sign_in.dart';

class VendorProfile extends StatelessWidget {
   VendorProfile({super.key});

FlutterSecureStorage storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(),
      body: Center(child:ElevatedButton(onPressed: ()async{
        await storage.delete(key: 'vendor_access_token');
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VendorSignIn(),), (route) => false);
      }, child: Text('signout'))),
    );
  }
}