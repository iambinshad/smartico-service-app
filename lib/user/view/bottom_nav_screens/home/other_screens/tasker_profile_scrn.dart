
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/chat/chat_connection_provider.dart';
import 'package:smartico/application/user/show_all_gigs/personalised_gigs.dart';
import 'package:smartico/core/widgets.dart';

class TaskerProfileScreen extends StatelessWidget {
  TaskerProfileScreen({super.key, required this.profilePic, this.chatIndex});

  String? profilePic;
  int? chatIndex;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<UserConnectionService,VendorAllGigsFetching>(
        builder: (context, value,value2, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                kHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("    "),
                    profilePic != "assets/splash/unknown.jpg"
                        ? CircleAvatar(
                            radius: 70,
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(profilePic!)),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage(
                              profilePic!,
                            ),
                          ),
                    const Text("    ")
                  ],
                ),
                Text(
                  value.sortedUsers![chatIndex!].fullName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 24),
                ),
                kHeight10,
                Text(
                  "${value.sortedUsers![chatIndex!].phone}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 19),
                ),
                const Divider(
                  thickness: 7,
                  color: Color.fromARGB(255, 240, 240, 240),
                ),
                kHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      value.sortedUsers![chatIndex!].about ??
                          "About section is null",
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      value.sortedUsers![chatIndex!].email!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                kHeight10,
                const Divider(
                  thickness: 7,
                  color: Color.fromARGB(255, 238, 237, 237),
                ),
                kHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text("Gigs"), Row(
                    children: [
                      Text("${value2.vendorAllGigs!.length}"),
                      const Icon(Icons.arrow_forward_ios_rounded,size: 13,)
                    ],
                  )],
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(image:DecorationImage(image: NetworkImage(value2.vendorAllGigs![index].image))),
                          );
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
