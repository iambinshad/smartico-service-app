import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/chat/chat_connection_provider.dart';
import 'package:smartico/application/user/show_all_gigs/personalised_gigs.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/controller/chat_function/chat_methods.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
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
      backgroundColor:const Color.fromARGB(255, 234, 234, 232),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:  const Color.fromARGB(255, 16, 81, 135),
        title: Text('Chat Screen', style: headText.copyWith(color: Colors.white)),
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
              builder: (context, value, child) => value.showList!=null
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return
                             value.showList!.isEmpty?const Center(child:Text('Search Item Not Found!',style: TextStyle(color: Colors.black),)):
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: 
                                   ListTile(
                                      onTap: () async {
                                        // value.connectionCount?[index].count = 0;
                                        String currentUserId =
                                            await getCurrentUserId();
                                        String currentUserName =
                                            await getCurrentUserName();
                            
                                        String chatRoomId = ChatMethods()
                                            .checkingId(
                                                vendorId:
                                                    value.showList![index].id!,
                                                currentUser: currentUserId);
                                        ChatingVendor chatingVendor =
                                            ChatingVendor(
                                                id: value.showList![index].id,
                                                vendorName: value
                                                    .showList![index]
                                                    .fullName);
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
                                                  currentUserName:
                                                      currentUserName,
                                                  profilePic: value
                                                      .showList![index]
                                                      .profilePhoto,
                                                ),
                                              ));
                                        }
                                        Provider.of<VendorAllGigsFetching>(context,listen: false).fetchVendorAllGigs(value.sortedUsers![index].id!);
                                      },
                                      leading: value.showList![index]
                                                  .profilePhoto ==
                                              null
                                          ? const CircleAvatar(
                                            radius: 26,
                                              backgroundImage: AssetImage(
                                                  "assets/splash/unknown.jpg"))
                                          : CircleAvatar(
                                            radius: 26,
                                              backgroundImage: NetworkImage(value
                                                  .showList![index]
                                                  .profilePhoto!)),
                                      title: Text(
                                          value.showList![index].fullName ??
                                              "unknown",style: normalText,),
                                      // subtitle:
                                      //     Text("${value.showList![index].phone}"),
                                      // trailing:
                                      //     value.connectionCount?[index].count != 0
                                      //         ? CircleAvatar(
                                      //             radius: 9,
                                      //             child: Text(
                                      //               '${value.connectionCount?[index].count}',
                                      //               style: const TextStyle(
                                      //                   fontSize: 12),
                                      //             ),
                                      //           )
                                      //         : const SizedBox()
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
}
