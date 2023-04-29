import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/profile/user_profile.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/authentication/user_sign_in.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/settings.dart';

import 'edit_profile.dart';

// ignore: must_be_immutable
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
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, value, child) => FutureBuilder(
          future: value.userDetails,
          builder: (context, snapshot) => SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/splash/bgImage.jpeg'),
                          fit: BoxFit.cover),
                    ),
                    width: double.infinity,
                    height: height / 5,
                    child:const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/splash/unknown.jpg'),
                              radius: 30,
                            ),
                    ),
                  ),
                  ColoredBox(
                    color: const Color.fromARGB(255, 243, 241, 241),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kHeight10,
                        Padding(
                          padding: const EdgeInsets.only(left: 17),
                          child: Text(
                            'Account',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
                        ),
                        Tile(
                          leading: Text(
                            "FullName",
                            style: normalText,
                          ),
                          trailing: Text(
                            snapshot.data?.fullName ?? "FullName",
                          ),
                        ),
                        Tile(
                          storage: storage,
                          trailing: Text("${snapshot.data?.phone ?? "Phone"} "),
                          leading: Text(
                            "Phone",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          trailing: Text(snapshot.data?.email ?? "Email"),
                          leading: Text(
                            "Email",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          trailing: Text(
                            snapshot.data?.status ?? "Status",
                            style: TextStyle(
                                color: snapshot.data?.status == 'Active'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w700),
                          ),
                          leading: Text(
                            "Status",
                            style: normalText,
                          ),
                        ),
                        kHeight10,
                      ],
                    ),
                  ),
                  kHeight10,
                  ColoredBox(
                    color: const Color.fromARGB(255, 243, 241, 241),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kHeight10,
                        Padding(
                          padding: const EdgeInsets.only(left: 17),
                          child: Text(
                            'Others',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
                        ),
                        Tile(
                          title: const Text(
                            'Edit Profile',
                          ),
                          leading: const CircleAvatar(child: Icon(Icons.edit)),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 17,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  EditUserProfile(fullName: snapshot.data?.fullName,phone:snapshot.data?.phone ,),
                                ));
                          },
                        ),
                        Tile(
                          storage: storage,
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 17,
                          ),
                          leading: const CircleAvatar(
                            child: Icon(
                              Icons.settings,
                              size: 17,
                            ),
                          ),
                          title: const Text('Settings'),
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsScreen(),
                                ));
                          },
                        ),
                        Tile(
                          storage: storage,
                          leading: const CircleAvatar(
                            child: Icon(
                              Icons.logout_outlined,
                            ),
                          ),
                          title: const Text('Sign Out'),
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Sign Out'),
                                content: const Text(
                                    'Are You Sure You Want To Sign Out From This Account?'),
                                actions: [
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.grey)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.red)),
                                    onPressed: () {
                                      signoutButtonClicked(context);
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> signoutButtonClicked(context) async {
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
  }
}

class Tile extends StatelessWidget {
  Tile(
      {super.key,
      this.storage,
      this.onTap,
      this.trailing,
      this.leading,
      this.title});

  final FlutterSecureStorage? storage;
  void Function()? onTap;
  Widget? trailing;
  Widget? leading;
  Widget? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Card(
        child: ListTile(
          trailing: trailing,
          onTap: onTap,
          leading: leading,
          title: title,
        ),
      ),
    );
  }
}
