import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/all_vendor_prov.dart';

import 'package:smartico/core/constants.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/controller/chat_function/chat_methods.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';

import 'messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 223, 221),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: Text('Messages', style: headText),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<GetAllVendor>(
              builder: (context, value, child) => ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      String currentUserId = await getAccesToken();

                      String chatRoomId = ChatMethods().checkingId(
                          vendorId: value.allVendors![index].id!,
                          currentUser: currentUserId);
                      ChatingVendor chatingVendor = ChatingVendor(
                          id: value.allVendors![index].id,
                          vendorName: value.allVendors![index].fullName);

                      if (context.mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesScreen(
                                chatRoomId: chatRoomId,
                                chatingVendor: chatingVendor,
                                token: currentUserId,
                              ),
                            ));
                      }
                    },
                    leading: const CircleAvatar(
                      radius: 28,
                    ),
                    title: Text(value.allVendors![index].fullName ?? "unknown"),
                    subtitle: const Text(
                      'You have to complete this..',
                    ),
                    trailing: Column(
                      children: [
                        const Text(
                          '10:40',
                        ),
                        CircleAvatar(
                          radius: 9,
                          child: Text(
                            '$index',
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: value.allVendors!.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
