import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
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
import 'package:smartico/application/admin/fetch_all_vendors/fetch_all_vendors_provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/all_vendor_prov.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/booking/cancel_booking.dart';
import 'package:smartico/application/user/chat/chat_connection_provider.dart';
import 'package:smartico/application/user/chat/message_provider.dart';
import 'package:smartico/application/user/profile/user_profile.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/user/show_all_gigs/personalised_gigs.dart';
import 'package:smartico/application/vendor/all_booking/cancel_user_bookings.dart';
import 'package:smartico/application/vendor/chat/chat_connection_provider.dart';
import 'package:smartico/application/vendor/profile/vendor_profile.dart';
import 'package:smartico/application/vendor/vendor_provider.dart';
import 'package:smartico/core/firebase/firebase_push_notification.dart';
import 'application/user/booking/book_gig_provider.dart';
import 'application/user/show_all_gigs/show_all_gigs.dart';
import 'application/user/user_provider.dart';
import 'application/vendor/all_booking/all_bookings.dart';
import 'application/vendor/complete_signup/complete_signup_provider.dart';
import 'application/vendor/gig_provider/new_gig_create_provider.dart';
import 'application/vendor/gig_provider/show_all_gig_provider.dart';
import 'common/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, 
  ));
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
    await FirebaseApi().initNotification();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
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
        ),
        ListenableProvider(
          create: (context) => CancelBookingprovider(),
        ),
        ListenableProvider(
          create: (context) => AllBookingProvider(),
        ),
        ListenableProvider(
          create: (context) => CancelUserBookingsProvider(),
        ),
        ListenableProvider(
          create: (context) => AllVendorListForAdmin(),
        ),
        ListenableProvider(
          create: (context) => UserProfileProvider(),
        ),
        ListenableProvider(
          create: (context) => VendorProfileProvider(),
        ),
        ListenableProvider(
          create: (context) => UserConnectionService(),
        ),
        ListenableProvider(
          create: (context) => VendorConnectionService(),
        ),
        ListenableProvider(
          create: (context) => SendMessageService(),
        ),
        ListenableProvider(
          create: (context) => VendorAllGigsFetching(),
        ),
      ],
      child: MaterialApp(
        title: 'Smartico Service Provider',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: 
          const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
