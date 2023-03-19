import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartico/view/user/user_sign_in.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      moveToNextPage(context);
    });
    return  const Scaffold(
      
      backgroundColor: Colors.white,
      body: Center(child: Image(image: AssetImage('assets/splash/logo3.webp',),width:kIsWeb? 400:300,height:kIsWeb?280:180,),),
    );
  }
  
  Future<void> moveToNextPage(context)async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  UserSignIn(),));

    
  }
}