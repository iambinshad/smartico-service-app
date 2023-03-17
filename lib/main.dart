import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/view/splash_screen.dart';

import 'application/user/user_password_provider.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ListenableProvider(create: (context) => UserPasswordProvider(),)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          
          useMaterial3: true,
          
          primarySwatch: Colors.blue,
          
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

