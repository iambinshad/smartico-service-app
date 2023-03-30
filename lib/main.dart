import 'package:flutter/material.dart' show BuildContext, Colors, MaterialApp, StatelessWidget, ThemeData, Widget, runApp;
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/vendor/vendor_provider.dart';
import 'package:smartico/common/splash_screen.dart';
import 'application/user/user_provider.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ListenableProvider(create: (context) => UserProvider(),),
      ListenableProvider(create: (context) => VendorProvider(),
      ),
      ListenableProvider(create: (context) => CommonProvider(),)
      ],
      child: MaterialApp(
        title: 'Smartico Service Provider',
        theme: ThemeData(
          
          useMaterial3: true,
          
          primarySwatch: Colors.blue,
          
        ),
        home:  const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

