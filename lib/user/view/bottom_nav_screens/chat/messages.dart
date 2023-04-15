import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/chat/message_provider.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import 'package:smartico/user/model/chat/message_model.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../../core/constants.dart';
import 'other_screens/message_tile.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen(
      {super.key,
      required this.chatRoomId,
      required this.chatingVendor,
      this.token});

  dynamic chatRoomId;
  dynamic token;
  final ChatingVendor chatingVendor;
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
        .orderBy("createdOn", descending: true)
        .snapshots(),
        builder: (context, snapshot) {
      List<MessageModelTwo> messageList = [];
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
                String previousDate;
                if (index < snapshot.data!.docs.length - 1) {
                  previousDate = DateFormat.yMMMMEEEEd()
                      .format(messageList[index + 1].createdOn!);
                } else {
                  previousDate = "";
                }
                String date = DateFormat.yMMMMEEEEd()
                    .format(messageList[index].createdOn!);
            
                return previousDate != date
                    ? dateDivider(messageList[index], context, token)
                    : message(
                        model: messageList[index],
                        context: context,
                        token: token);
              },
              itemCount: snapshot.data!.docs.length,
            ),
          ),
          Expanded(
            flex: 1,

            child: Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Consumer<MessageProvider>(
                builder: (context, value, child) => 
                 MyTextFormField(controller: Provider.of<MessageProvider>(context,listen: false).messageController,suffixIcon:IconButton(onPressed:(){value.sendButtonClicked(userId:chatingVendor.id!, chatRoomId: chatRoomId);}, icon:const Icon(Icons.send)),)),
            )
          )
        ],
      );
        },
      ),
    );
  }

  StickyHeaderBuilder dateDivider(
      MessageModelTwo state, BuildContext context, token) {
// final token = await getAccesToken();

    return StickyHeaderBuilder(
      builder: (context, stuckAmount) {
        String dateOfChat = state.createdOn.toString();
        DateTime convertedDate = state.createdOn!;
        log("${convertedDate.toString()} is the date");
        if (convertedDate.day == DateTime.now().day &&
            convertedDate.month == DateTime.now().month &&
            convertedDate.year == DateTime.now().year) {
          dateOfChat = "Today";
        } else if (convertedDate.day == DateTime.now().day - 1 &&
            convertedDate.month == DateTime.now().month &&
            convertedDate.year == DateTime.now().year) {
          dateOfChat = "Yesterday";
        } else {
          dateOfChat = DateFormat.yMMMMEEEEd().format(convertedDate);
        }

        return Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              dateOfChat,
            ),
          ),
        );
      },
      content: message(model: state, context: context, token: token),
    );
  }
}

class MessagingContainer extends StatelessWidget {
  const MessagingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 310,
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Hello , Iam cristinal,I need Your service',
                    style: normalText,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text('10:40')],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReplyContainer extends StatelessWidget {
  const ReplyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 240,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ok , we are ready to do for you',
                    style: normalText,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text('10:50')],
              )
            ],
          ),
        ),
      ),
    );
  }
}
