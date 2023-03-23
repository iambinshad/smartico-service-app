import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/vendor/vendor_provider.dart';
import 'package:smartico/common/splash_screen.dart';
import 'package:smartico/user/view/authentication/user_sign_up.dart';
import 'package:smartico/vendor/view/authentication/vendor_signup_firsrt_scrn.dart';
import 'package:smartico/vendor/view/authentication/vendor_signup_secon_scrn.dart';

import 'application/user/user_provider.dart';
import 'common/roll_selecting.dart';




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
        home:   VendorSignUPScrnOne(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

