import 'package:firebase_core/firebase_core.dart';
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
import 'package:smartico/application/user/all_vendor_prov.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/chat/message_provider.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/vendor/vendor_provider.dart';
import 'package:smartico/user/view/bottom_nav/bottom_nav.dart';
import 'package:smartico/vendor/view/bottom_nav/vendor_bottom_nav.dart';
import 'application/user/booking/book_gig_provider.dart';
import 'application/user/show_all_gigs/show_all_gigs.dart';
import 'application/user/user_provider.dart';
import 'application/vendor/complete_signup/complete_signup_provider.dart';
import 'application/vendor/gig_provider/new_gig_create_provider.dart';
import 'application/vendor/gig_provider/show_all_gig_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  await Firebase.initializeApp();
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
        ),
        ListenableProvider(
          create: (context) => SingleGigDetailsProvider(),
        ),
        ListenableProvider(
          create: (context) => CompleteSignUpProvider(),
        ),
        ListenableProvider(
          create: (context) => BookGigPrvider(),
        ),
        ListenableProvider(
          create: (context) => ReservedGigs(),
        ),
        ListenableProvider(
          create: (context) => GetAllVendor(),
        ),
        ListenableProvider(
          create: (context) => MessageProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Smartico Service Provider',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const UserBottomNavBar(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
