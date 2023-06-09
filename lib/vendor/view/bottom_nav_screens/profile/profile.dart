import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/profile/vendor_profile.dart';
import 'package:smartico/common/settings_scrn/settings_screen.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/authentication/user_sign_in.dart';
import 'package:smartico/user/view/bottom_nav/bottom_nav.dart';
import 'package:smartico/vendor/view/authentication/vendor_sign_in.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/profile/edit_vendor_profile.dart';

// ignore: must_be_immutable
class VendorProfile extends StatelessWidget {
  VendorProfile({super.key});

  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<VendorProfileProvider>(context, listen: false)
          .getVendorDetails();
    });
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<VendorProfileProvider>(
        builder: (context, value, child) => FutureBuilder(
          future: value.vendorDetails,
          builder: (context, snapshot) => SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/splash/bgImage.jpeg'),
                          fit: BoxFit.fill),
                    ),
                    width: double.infinity,
                    height: height / 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: snapshot.data?.profilePhoto != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data!.profilePhoto!,
                              ),
                              radius: 30,
                            )
                          : const CircleAvatar(
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
                          storage: storage,
                          subtitle: Text(
                            snapshot.data?.status ?? "",
                            style: TextStyle(
                                color: snapshot.data?.status == 'Approved'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w700),
                          ),
                          title: Text(
                            "Status",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          title: Text(
                            "Username",
                            style: normalText,
                          ),
                          subtitle: Text(
                            snapshot.data?.fullName ?? "dkd",
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text("${snapshot.data?.phone ?? ""} "),
                          title: Text(
                            "Phone",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.email ?? ""),
                          title: Text(
                            "Email",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(
                              snapshot.data?.date?.toIso8601String() ?? ""),
                          title: Text(
                            "DOB",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.gender ?? ""),
                          title: Text(
                            "Gender",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.about ?? ""),
                          title: Text(
                            "About",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.github ?? ""),
                          title: Text(
                            "Github",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.googleDrive ?? ""),
                          title: Text(
                            "GoogleDrive",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.linkedIn ?? ""),
                          title: Text(
                            "LinkedIn",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.skill ?? ""),
                          title: Text(
                            "Skills",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(
                            "${snapshot.data?.address?.pincode ?? ""}",
                          ),
                          title: Text(
                            "Pincode",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(
                              snapshot.data?.address?.currentAddress ?? ""),
                          title: Text(
                            "CurrentAddress",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.address?.country ?? ""),
                          title: Text(
                            "Country",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.address?.state ?? ""),
                          title: Text(
                            "State",
                            style: normalText,
                          ),
                        ),
                        Tile(
                          storage: storage,
                          subtitle: Text(snapshot.data?.address?.city ?? ""),
                          title: Text(
                            "City",
                            style: normalText,
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
                                  builder: (context) => VendorProfileEdit(
                                      profilePic: snapshot.data?.profilePhoto,
                                      userName: snapshot.data?.userName,
                                      mobile: "${snapshot.data?.phone}",
                                      gender: "${snapshot.data?.gender}",
                                      skills: "${snapshot.data?.skill}",
                                      googledrive:
                                          "${snapshot.data?.googleDrive}",
                                      linkedIn: "${snapshot.data?.linkedIn}",
                                      github: "${snapshot.data?.github}",
                                      about: "${snapshot.data?.about}",
                                      currentAddress:
                                          "${snapshot.data?.address?.currentAddress}",
                                      country:
                                          "${snapshot.data?.address?.country}",
                                      state: "${snapshot.data?.address?.state}",
                                      city: "${snapshot.data?.address?.city}"),
                                ));
                          },
                        ),
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
                            'System',
                            style: normalText.copyWith(color: Colors.blue),
                          ),
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
                          onTap: () {
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
                            child: Icon(Icons.restart_alt_rounded),
                          ),
                          title: const Text("Swich User"),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Switch User"),
                                content: const Text(
                                    'Are You Sure You Want To Switch To User'),
                                actions: [
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.grey)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.red)),
                                    onPressed: () async {
                                      FlutterSecureStorage storage =
                                          const FlutterSecureStorage();
                                      String? user = await storage.read(
                                          key: 'user_access_token');
                                      if (context.mounted) {}
                                      if (user != null) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const UserBottomNavBar(),
                                            ),
                                            (route) => false);
                                      } else {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserSignIn(),
                                            ),
                                            (route) => false);
                                      }
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
                                    onPressed: () async {
                                      yesClicked(context);
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
    );
  }

  void yesClicked(context) async {
    await storage.delete(key: 'vendor_access_token');
    await storage.delete(key: 'vendorId');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => VendorSignIn(),
        ),
        (route) => false);
  }
}

class Tile extends StatelessWidget {
  Tile(
      {super.key,
      this.storage,
      this.onTap,
      this.trailing,
      this.leading,
      this.subtitle,
      this.title});

  final FlutterSecureStorage? storage;
  void Function()? onTap;
  Widget? trailing;
  Widget? leading;
  Widget? title;
  Widget? subtitle;

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
          subtitle: subtitle,
        ),
      ),
    );
  }
}
