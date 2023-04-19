import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/user/view/authentication/user_sign_in.dart';

class UserProfilePage extends StatelessWidget {
   UserProfilePage({super.key});
FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(child: ElevatedButton(onPressed: ()async{
     await storage.delete(key: 'access_token');
     if(context.mounted){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => UserSignIn(),), (route) => false);

     }
    }, child: const Text('Logout'))),);
  }
}