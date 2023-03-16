import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/user_password_provider.dart';
import 'package:smartico/presentation/splash_screen.dart';

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

