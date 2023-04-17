import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/all_vendor_prov.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/controller/chat_function/chat_methods.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';

import 'messages.dart';

class UserChatScreen extends StatelessWidget {
  const UserChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //  Provider.of<CommonProvider>(context, listen: false)
    //       .setShimmerLoading(true);
          Provider.of<GetAllVendor>(context, listen: false).showList=Provider.of<GetAllVendor>(context, listen: false).allVendors;
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   context.read<CommonProvider>().setShimmerLoading(false);
      // }); 
         }
         );
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
                child: Consumer<GetAllVendor>(
                  builder: (context, values, child) => 
                  CupertinoSearchTextField(
                    onChanged: (value) =>values.filterChatList(value) ,
                    backgroundColor: Colors.white,
                  ),
                )),
          ),
          Expanded(
            child: Consumer<GetAllVendor>(
              builder: (context, value, child) =>value.allVendors !=null? ListView.builder(
                itemBuilder: (context, index) {
                  return value.showList !=null? ListTile(
                    onTap: () async {
                      String currentUserId = await getCurrentUserId();
                      String currentUserName = await getCurrentUserName();

                      String chatRoomId = ChatMethods().checkingId(
                          vendorId: value.showList![index].id!,
                          currentUser: currentUserId);
                      ChatingVendor chatingVendor = ChatingVendor(
                          id: value.showList![index].id,
                          vendorName: value.showList![index].fullName);

                      if (context.mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserMessagesScreen(
                                chatRoomId: chatRoomId,
                                chatingVendor: chatingVendor,
                                currentUserId: currentUserId,
                                currentUserName: currentUserName,
                              ),
                            ));
                      }
                    },
                    leading: const CircleAvatar(
                      radius: 28,
                    ),
                    title: Text(value.showList![index].fullName ?? "unknown"),
                    subtitle:  Text(value.showList![index].gender!),
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
                  ):Center(child:Text('Search Item Not Found!'));
                },
                itemCount: value.showList!.length,
              ):Center(child:Text('Chat List Not Found!')),
            ),
          )
        ],
      ),
    );
  }
}
