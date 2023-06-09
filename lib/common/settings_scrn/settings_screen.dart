import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smartico/common/settings_scrn/about.dart';
import 'package:smartico/common/settings_scrn/privacy_policy.dart';
import 'package:smartico/common/settings_scrn/terms_and_conditions.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/user/view/bottom_nav_screens/profile/user_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Version 1.0',style: normalText.copyWith(fontSize: 17,color:const Color.fromARGB(255, 119, 119, 119)),),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
        title: Text(
          'Settings',
          style: headText,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Tile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen(),));
              },
              trailing: const Icon(Icons.arrow_forward_ios_rounded, ),
              title: Text(
                'About Smartico',
                style: normalText,
              ),
              leading: const CircleAvatar(
                child: Icon(
                  Icons.info,
                  size: 28,
                ),
              ),
            ),
            Tile(
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
                title: Text(
                  'Terms & Policy',
                  style: normalText,
                ),
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.format_align_justify,
                    size: 28,
                  ),
                ),onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsAndConditionsScreen(),));
                },),
            Tile(
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPoclicyScrn(),)),
              title: Text(
                'Privacy Policy',
                style: normalText,
              ),
              leading: const CircleAvatar(
                child: Icon(
                  Icons.privacy_tip_outlined,
                  size: 28,
                ),
              ),
            ),
            Tile(
              title: Text(
                'Share Smartico',
                style: normalText,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              leading: const CircleAvatar(
                child: Icon(
                  Icons.share_outlined,
                  size: 28,
                ),
              ),
              onTap: () async {
                await Share.share(
                    'hey! check out this new app https://play.google.com/store/search?q=music%20application&c=apps');
              },
            ),
            Tile(
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () =>LaunchReview.launch(
                androidAppId: "com.example.smartico"
              ),
              title: Text(
                'Rate Smartico',
                style: normalText,
              ),
              leading: const CircleAvatar(
                child: Icon(
                  Icons.rate_review,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
