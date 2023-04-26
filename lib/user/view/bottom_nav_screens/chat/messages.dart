import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/chat/message_provider.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import '../../../../core/constants.dart';
import 'other_screens/message_tile.dart';

// ignore: must_be_immutable
class UserMessagesScreen extends StatelessWidget {
  UserMessagesScreen(
      {super.key,
      required this.chatRoomId,
      required this.chatingVendor,
      this.currentUserId,
      this.currentUserName});

  dynamic chatRoomId;
  dynamic currentUserId;
  dynamic currentUserName;
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
        backgroundColor: mainColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/works/profile pic.jpg'),
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
              Consumer<MessageProvider>(
                  builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: MyTextFormField(
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
                                if (chatedCount == 'No') {
                                  chatedCount = 'Yes';
                                  await storage.write(
                                      key: chatingVendor.id.toString(),
                                      value: chatedCount);
                                  await _firestore.collection('chats').add({
                                    'vendor': chatingVendor.id,
                                    'senderName': currentUserName,
                                    'senderId': currentUserId,
                                  });

                                  log('startPrco');
                                }
                                value.sendButtonClicked(
                                    userId: chatingVendor.id!,
                                    chatRoomId: chatRoomId);
                                    
                              },
                              icon: const Icon(
                                Icons.send,
                                size: 26,
                              )),
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
