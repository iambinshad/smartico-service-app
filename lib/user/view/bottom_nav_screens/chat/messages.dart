import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/chat/chat_connection_provider.dart';
import 'package:smartico/application/user/chat/message_provider.dart';
import 'package:smartico/application/user/profile/user_profile.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/tasker_profile_scrn.dart';
import '../../../../core/constants.dart';
import 'other_screens/message_tile.dart';

// ignore: must_be_immutable
class UserMessagesScreen extends StatelessWidget {
  UserMessagesScreen(
      {super.key,
      required this.chatRoomId,
      required this.chatingVendor,
      this.currentUserId,
      this.currentUserName,
      this.profilePic,this.chatindex});

int? chatindex;
  dynamic chatRoomId;
  dynamic currentUserId;
  dynamic currentUserName;
  String? profilePic;
  String chatedCount = 'No';
  FlutterSecureStorage storage = const FlutterSecureStorage();
  // CollectionReference vendormsgCollection = FirebaseFirestore.instance.collection('forVendor');
  final ChatingVendor chatingVendor;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      chatedCount = await checkChatCount();
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 206, 158),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskerProfileScreen(
                      profilePic: profilePic ?? "assets/splash/unknown.jpg",chatIndex: chatindex),
                ));
          },
          child: Row(
            children: [
              profilePic == null
                  ? const CircleAvatar(
                      backgroundImage: AssetImage('assets/splash/unknown.jpg'),
                      radius: 20,
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(profilePic!),
                      radius: 23,
                    ),
              const SizedBox(
                width: 10,
              ),
              Text(
                chatingVendor.vendorName!,
                style: mediumText,
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection("chatRoom")
            .doc(chatRoomId)
            .collection("chats")
            .orderBy("createdon", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          log(chatRoomId);
          if (!snapshot.hasData) {
            log("snapshot has not data");
            return Container();
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Check Your Internet Connection'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Expanded(
                flex: 10,
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map =
                        snapshot.data!.docs[index].data();
                    return message(
                        model: map, context: context, currentId: currentUserId);
                  },
                  itemCount: snapshot.data!.docs.length,
                ),
              ),
              Consumer2<MessageProvider, UserProfileProvider>(
                  builder: (context, value1, value2, child) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: FutureBuilder(
                          future: value2.userDetails,
                          builder: (context, snapshot) => MyTextFormField(
                            prefixIcon: const Icon(
                              Icons.tag_faces_outlined,
                              size: 28,
                            ),
                            hintText: 'message',
                            controller: Provider.of<MessageProvider>(context,
                                    listen: false)
                                .messageController,
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  value1.sendButtonClicked(
                                      userId: chatingVendor.id!,
                                      chatRoomId: chatRoomId);
                                  // final currentUser = await getCurrentUserId();
                                  Provider.of<SendMessageService>(context,
                                          listen: false)
                                      .sendMessageService(currentUserId,
                                          chatingVendor.id, context);
                                },
                                icon: const Icon(
                                  Icons.send,
                                  size: 26,
                                )),
                          ),
                        ),
                      ))
            ],
          );
        },
      ),
    );
  }

  Future<String> checkChatCount() async {
    final countS = await storage.read(key: chatingVendor.toString());
    return countS ?? 'No';
  }
}
