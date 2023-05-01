import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:smartico/core/constants.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/controller/chat_function/chat_methods.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/chats/messages.dart';

// ignore: must_be_immutable
class VendorChatScrn extends StatelessWidget {
  VendorChatScrn({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic vid;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      vid = await getid();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: mainColor,
        title: Text('Messages', style: headText),
      ),
      body: Column(
        children: [
          ColoredBox(
            color: mainColor,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                backgroundColor: Colors.white,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection("chats").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                log('snapshot has no data');
                return const Center(
                  child: Text("Chat List Empty"),
                );
              }
              if (snapshot.hasError) {
                log('error');
                return const Center(
                  child: Text('Check you internet Connection'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: !snapshot.hasData
                    ? const Center(
                        child: Text('Chat List Empty'),
                      )
                    : ListView.builder(
                        reverse: false,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          if (vid.toString() == data['vendor']) {
                            return InkWell(
                              onTap: () {
                                String chatRoomId = ChatMethods().checkingId(
                                    vendorId: vid,
                                    currentUser: data['senderId']);
                                ChatingUser chatingUser = ChatingUser(
                                    id: data['senderId'],
                                    userName: data['senderName']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VendorMessagesScreen(
                                        chatRoomId: chatRoomId,
                                        chatingUser: chatingUser,
                                        currentVendorId: vid,profilePic:data['senderPic'],),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Card(
                                  child: ListTile(
                                    leading: data['senderPic'] == null
                                        ? const CircleAvatar(
                                            radius: 30,
                                            backgroundImage: AssetImage(
                                                'assets/splash/unknown.jpg'),
                                          )
                                        : CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                NetworkImage(data['senderPic']),
                                          ),
                                    title: Text(data['senderName'] ?? "Binshad"),
                                    subtitle:
                                        Text(data['senderId'] ?? "senderId"),
                                  ),
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<String> getid() async {
    final vendorId = await getCurrentVendorId();
    return vendorId;
  }
}
