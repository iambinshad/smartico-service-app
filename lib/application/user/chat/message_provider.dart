import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartico/user/model/chat/message_model.dart';

class MessageProvider with ChangeNotifier {
  TextEditingController messageController = TextEditingController();

  Future<void> sendButtonClicked(
      {required String userId, required String chatRoomId}) async {
    if(messageController.text.isNotEmpty){
      log('inside if');
      MessageModel messageModel = MessageModel(
        sendBy: userId,
        createdOn: FieldValue.serverTimestamp(),
        seen: false,
        message: messageController.text);

    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageModel.tojson());
    messageController.clear();
    }else{
      
      log('Enter some Message');
    }
  }


}
