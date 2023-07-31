import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/chat/chat_connection_provider.dart';
import 'package:smartico/application/user/show_all_gigs/personalised_gigs.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/controller/chat_function/chat_methods.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'messages.dart';

class UserChatScreen extends StatelessWidget {
  const UserChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserConnectionService>(context, listen: false)
          .userConnection();
      Provider.of<UserConnectionService>(context, listen: false).showList =
          Provider.of<UserConnectionService>(context, listen: false)
              .sortedUsers;
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
        title:
            Text('Chat Screen', style: headText.copyWith(color: Colors.white)),
      ),
      body: Column(
        children: [
          ColoredBox(
            color: const Color.fromARGB(255, 16, 81, 135),
            child: Padding(
                padding: const EdgeInsets.only(right: 13, left: 13, bottom: 5),
                child: Consumer<UserConnectionService>(
                  builder: (context, values, child) => CupertinoSearchTextField(
                    onChanged: (value) => values.filterChatList(value),
                    backgroundColor: Colors.white,
                  ),
                )),
          ),
          Expanded(
            child: Consumer<UserConnectionService>(
              builder: (context, value, child) => value.showList != null
                  ? ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return value.showList!.isEmpty
                            ? const Center(
                                child: Text(
                                'Search Item Not Found!',
                                style: TextStyle(color: Colors.black),
                              ))
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  onTap: () async {
                                    String currentUserId =
                                        await getCurrentUserId();
                                    String currentUserName =
                                        await getCurrentUserName();

                                    String chatRoomId = ChatMethods()
                                        .checkingId(
                                            vendorId:
                                                value.showList![index].id!,
                                            currentUser: currentUserId);
                                    ChatingVendor chatingVendor = ChatingVendor(
                                        id: value.showList![index].id,
                                        vendorName:
                                            value.showList![index].fullName);
                                    log(chatRoomId.toString(),
                                        name: "ChatROomId");
                                    if (context.mounted) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserMessagesScreen(
                                              chatindex: index,
                                              chatRoomId: chatRoomId,
                                              chatingVendor: chatingVendor,
                                              currentUserId: currentUserId,
                                              currentUserName: currentUserName,
                                              profilePic: value.showList![index]
                                                  .profilePhoto,
                                            ),
                                          ));
                                    }
                                    if(context.mounted){Provider.of<VendorAllGigsFetching>(context,
                                            listen: false)
                                        .fetchVendorAllGigs(
                                            value.sortedUsers![index].id!);}
                                  },
                                  subtitle: Text(
                                      value.showList![index].email.toString()),
                                  trailing: CircleAvatar(
                                    child: IconButton(
                                        onPressed: () {
                                          if (value.showList![index].phone !=
                                              null) {
                                            _makePhoneCall(value
                                                .showList![index].phone
                                                .toString());
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Phone Details Empty")));
                                          }
                                        },
                                        icon: const Icon(Icons.phone)),
                                  ),
                                  leading:
                                      value.showList![index].profilePhoto ==
                                              null
                                          ? const CircleAvatar(
                                              radius: 26,
                                              backgroundImage: AssetImage(
                                                  "assets/splash/unknown.jpg"))
                                          : CachedNetworkImage(
                                              imageUrl: value.showList![index]
                                                  .profilePhoto!,
                                              placeholder: (context, url) =>
                                                  const CircleAvatar(
                                                radius: 26,
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                          radius: 26,
                                                          backgroundImage:
                                                              imageProvider),
                                            ),
                                  title: Text(
                                    value.showList![index].fullName ??
                                        "unknown",
                                    style: normalText,
                                  ),
                                ),
                              );
                      },
                      itemCount: value.showList!.length,
                    )
                  : const Center(child: Text('Chat List Not Found!')),
            ),
          )
        ],
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    try {
      await launchUrl(Uri.parse("tel://$phoneNumber)"));
    } on PlatformException catch (e) {
      log(e.message.toString());
    }
  }
}
