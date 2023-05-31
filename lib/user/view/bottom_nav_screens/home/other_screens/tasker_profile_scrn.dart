import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/chat/chat_connection_provider.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/user/show_all_gigs/personalised_gigs.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/work_descrip.dart';

class TaskerProfileScreen extends StatelessWidget {
  TaskerProfileScreen({super.key, required this.profilePic, this.chatIndex});

  String? profilePic;
  int? chatIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer3<UserConnectionService, VendorAllGigsFetching,
        RecentServicesProvider>(
      builder: (context, value, value2, value3, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    kHeight15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
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
                          fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                    kHeight10,
                    Text(
                      "${value.sortedUsers![chatIndex!].phone}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 19),
                    ),
                    kHeight10,
                  ],
                ),
              ),
              // ColoredBox(color: Colors.white30,),

              Card(
                child: ColoredBox(
                  color: const Color.fromARGB(57, 206, 205, 205),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              value.sortedUsers![chatIndex!].about ??
                                  "About section is null",
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
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
                      ],
                    ),
                  ),
                ),
              ),

              // const Divider(
              //   thickness: 7,
              //   color: Color.fromARGB(255, 238, 237, 237),
              // ),

              Card(
                child: ColoredBox(
                  color: Color.fromARGB(57, 206, 205, 205),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Gigs",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Text("${value2.vendorAllGigs!.length}"),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 13,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 130,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ListView.builder(
                                    itemCount: value2.vendorAllGigs!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await context
                                                  .read<
                                                      SingleGigDetailsProvider>()
                                                  .getGig(
                                                      value3.allGigs![index].id,
                                                      context);
                                              // ignore: use_build_context_synchronously
                                              await Provider.of<ReservedGigs>(
                                                      context,
                                                      listen: false)
                                                  .getreveiws(value3
                                                      .allGigs![index].id);

                                              if (context.mounted) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ServiceDescriptionScrn(),
                                                    ));
                                              }
                                            },
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(value2
                                                          .vendorAllGigs![index]
                                                          .image),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                            ),
                                          ),
                                          kWidth10,
                                        ],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
