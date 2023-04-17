import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:smartico/core/constants.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/controller/chat_function/chat_methods.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/chats/messages.dart';

class VendorChatScrn extends StatelessWidget {
  VendorChatScrn({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
dynamic vid;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      vid = await getid();
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 223, 221),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: Text('Messages', style: headText),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("chats").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            log('snapshot has no data');
            return const Center(
              child: Text("no one messaged"),
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
         return ListView.builder(
  itemCount: snapshot.data!.docs.length,
  itemBuilder: (BuildContext context, int index) {
    DocumentSnapshot document = snapshot.data!.docs[index];
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (vid.toString() == data['vendor']) {
      return InkWell(
        onTap: () {
          String chatRoomId = ChatMethods().checkingId(vendorId: vid, currentUser: data['senderId']);
          ChatingUser chatingUser = ChatingUser(id: data['senderId'], userName: data['senderName']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => VendorMessagesScreen(chatRoomId: chatRoomId, chatingUser: chatingUser,currentVendorId:vid),),);
        },
        child: ListTile(
          leading: const CircleAvatar(radius: 30,backgroundColor: Colors.green,),
          title: Text(data['senderName']),
          subtitle: Text(data['senderId']),
        ),
      );
    }
    // no need for else statement
    return ListTile();
  },
);
          // return ListView(
          //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //     Map<String, dynamic> data =
          //         document.data() as Map<String, dynamic>;
          //         // log(data['vendor']);
          //         log(vid.toString());
          //     if (vid.toString() == data['vendor']) {
          //       return ListTile(
          //         title: Text(data['senderName']),
          //         subtitle: Text(data['senderId']),
          //       );
          //     }
          //     return const ListTile(
          //       title: Text('nothing'),
          //     );
          //   }).toList(),
          // );
          
        },
      ),
    );
  }
  
  Future<String>getid()async {
 final vendorId = await getCurrentVendorId();
return vendorId;
  }
}
