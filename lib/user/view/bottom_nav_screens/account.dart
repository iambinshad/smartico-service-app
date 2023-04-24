import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/profile/user_profile.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/authentication/user_sign_in.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/settings.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});
  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<UserProfileProvider>(context, listen: false)
            .getUserDetails();
      },
    );
    return Scaffold(
        body: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: const Text('Profile'),
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, value, child) => FutureBuilder(
          future: value.userDetails,
          builder: (context, snapshot) => Center(
            child: Column(
              children: [
                kHeight20,
                const CircleAvatar(
                  radius: 60,
                ),
                kHeight10,
                Text(
                  'Mohammed Binshad P',
                  style: normalText,
                ),
                const Text('binshadp999@gmail.com'),
                const Text(
                  'Active',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                kHeight10,
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Edit Profile",
                      style: normalText,
                    )),
                kHeight10,
                Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10),
                  child: Card(
                    child: ListTile(
                      onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(),)) ,
                      leading: const CircleAvatar(child: Icon(Icons.settings)),
                      title: Text(
                        'Settings',
                        style: normalText,
                      ),
                      trailing: const CircleAvatar(
                        radius: 17,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10),
                  child: Card(
                    child: ListTile(
                      onTap: () async {
                        await storage.delete(key: 'user_access_token');
                        await storage.delete(key: 'currentUserName');
                        await storage.delete(key: 'currentUserId');
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserSignIn(),
                              ),
                              (route) => false);
                        }
                      },
                      leading: const CircleAvatar(
                          child: Icon(Icons.logout_outlined)),
                      title: Text(
                        'Logout',
                        style: normalText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
