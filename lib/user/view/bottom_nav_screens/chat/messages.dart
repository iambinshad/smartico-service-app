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

class MessagesScreen extends StatelessWidget {
  MessagesScreen(
      {super.key,
      required this.chatRoomId,
      required this.chatingVendor,
      this.currentUserId});

  dynamic chatRoomId;
  dynamic currentUserId;
  int chatedCount = 0;
  FlutterSecureStorage storage = FlutterSecureStorage();
  final ChatingVendor chatingVendor;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      chatedCount = checkChatCount() as int;
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 206, 158),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/works/profile pic.jpg'),
              radius: 24,
            ),
            const SizedBox(
              width: 5,
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
            // .orderBy("createdOn", descending: true)
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
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map =
                        snapshot.data!.docs[index].data();
                    return message(
                        model: map,
                        context: context,
                        currentUserId: currentUserId);
                  },
                  itemCount: snapshot.data!.docs.length,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Consumer<MessageProvider>(
                        builder: (context, value, child) => MyTextFormField(
                              controller: Provider.of<MessageProvider>(context,
                                      listen: false)
                                  .messageController,
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    if (chatedCount == 0) {
                                      chatedCount++;
                                      await storage.write(
                                          key: chatingVendor.id.toString(),
                                          value: chatedCount.toString());

                                      log('startPrco');
                                    }
                                    value.sendButtonClicked(
                                        userId: chatingVendor.id!,
                                        chatRoomId: chatRoomId);
                                  },
                                  icon: const Icon(Icons.send)),
                            )),
                  ))
            ],
          );
        },
      ),
    );
  }

  Future<int> checkChatCount() async {
    final countS = await storage.read(key: chatingVendor.toString());
    final count = int.parse(countS!);

    return count;
  }
}
