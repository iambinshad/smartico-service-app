import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        MaterialApp,
        StatelessWidget,
        ThemeData,
        Widget,
        runApp;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/admin/admin_provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/vendor/vendor_provider.dart';
import 'package:smartico/common/splash_screen.dart';
import 'application/user/show_all_gigs/show_all_gigs.dart';
import 'application/user/user_provider.dart';
import 'application/vendor/gig_provider/new_gig_create_provider.dart';
import 'application/vendor/gig_provider/show_all_gig_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(
          create: (context) => UserProvider(),
        ),
        ListenableProvider(
          create: (context) => VendorProvider(),
        ),
        ListenableProvider(
          create: (context) => CommonProvider(),
        ),
        ListenableProvider(
          create: (context) => AdminProvider(),
        ),
        ListenableProvider(
          create: (context) => NewGIgCreateProvider(),
        ),
        ListenableProvider(
          create: (context) => ShowAllGigsProvider(),
        ),
        ListenableProvider(
          create: (context) => RecentServicesProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Smartico Service Provider',
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
