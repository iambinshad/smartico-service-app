import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/chat/chat_connection_provider.dart';

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
Provider.of<VendorConnectionService>(context,listen: false).showList = Provider.of<VendorConnectionService>(context,listen: false).sortedVendors;
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 223, 223, 221),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: Text('Messages', style: headText),
      ),
      body: Column(
        children: [
          ColoredBox(
            color: const Color.fromARGB(255, 121, 216, 206),
            child: Padding(
                padding: const EdgeInsets.only(right: 13, left: 13, bottom: 5),
                child: Consumer<VendorConnectionService>(
                  builder: (context, values, child) => 
                  CupertinoSearchTextField(
                    onChanged: (value) =>values.filterChatList(value) ,
                    backgroundColor: Colors.white,
                  ),
                )),
          ),
          Expanded(
            child: Consumer<VendorConnectionService>(
              builder: (context, value, child) =>value.sortedVendors !=null? ListView.builder(
                itemBuilder: (context, index) {
                  return
                   value.showList !=null?
                   Card(
                    child: ListTile(

                      onTap: () async {
                         value.connectionCount?[index].count = 0;
                        String currentVendorId = await getCurrentVendorId();                  
                        String chatRoomId = ChatMethods().checkingId(
                            vendorId: currentVendorId,
                            currentUser: value.showList![index].id);
                            log(chatRoomId.toString(),name: "ChatROomId");
                        ChatingUser chatingUser = ChatingUser(
                          userName:value.showList![index].fullName ,
                            id: value.showList![index].id,
                            );
                  
                        if (context.mounted) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VendorMessagesScreen(chatRoomId: chatRoomId, chatingUser: chatingUser,currentVendorId:currentVendorId,profilePic:value.showList![index].profilePhoto ,)
                              ));
                        }
                      },
                      leading: value.showList![index].profilePhoto == null? const CircleAvatar(
                        backgroundImage:AssetImage("assets/splash/unknown.jpg")
                      ):CircleAvatar(
                        backgroundImage:NetworkImage(value.showList![index].profilePhoto!)
                      ),
                      title: Text(value.showList![index].fullName),
                      
                      trailing: value.connectionCount![index].count!=0? CircleAvatar(
                        radius: 9,
                        child: Text(
                          '${value.connectionCount![index].count}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ):const SizedBox()
                    ),
                  ):const Center(child: Text("No Chat Found!"),);
                  
                },
                itemCount: value.showList!.length,
              ):const Text('Chat List Not Found!'),
            ),
          )
        ],
      ),
    );
  }

}
