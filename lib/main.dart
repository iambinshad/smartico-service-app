import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/vendor/vendor_provider.dart';
import 'package:smartico/common/splash_screen.dart';
import 'package:smartico/user/view/bottom_nav/bottom_nav.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/user_home.dart';

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
        title: 'Flutter Demo',
        theme: ThemeData(
          
          useMaterial3: true,
          
          primarySwatch: Colors.blue,
          
        ),
        home:   BottomNavBar(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

