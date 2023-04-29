import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/chat/message_provider.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import 'package:smartico/user/view/bottom_nav_screens/chat/other_screens/message_tile.dart';
import '../../../../core/constants.dart';

// ignore: must_be_immutable
class VendorMessagesScreen extends StatelessWidget {
  VendorMessagesScreen({
    super.key,
    required this.chatRoomId,
    required this.chatingUser,
    this.currentVendorId,
  });

  dynamic chatRoomId;
  dynamic currentVendorId;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final ChatingUser chatingUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
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
              chatingUser.userName??"Binshad",
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
                  reverse: false,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map =
                        snapshot.data!.docs[index].data();
                    return message(
                        model: map,
                        context: context,
                        currentId: currentVendorId);
                  },
                  itemCount: snapshot.data!.docs.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Consumer<MessageProvider>(
                    builder: (context, value, child) => MyTextFormField(
                      prefixIcon:const Icon(Icons.tag_faces_sharp,size: 27,),
                      hintText: "message",
                          controller: Provider.of<MessageProvider>(context,
                                  listen: false)
                              .messageController,
                          suffixIcon: IconButton(
                              onPressed: () {
                                value.sendButtonClicked(
                                    userId: chatingUser.id!,
                                    chatRoomId: chatRoomId);
                              },
                              icon: const Icon(
                                Icons.send,
                                size: 26,
                              )),
                        )),
              )
            ],
          );
        },
      ),
    );
  }
}
