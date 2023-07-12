import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/chat/chat_connection_provider.dart';

import 'package:smartico/core/constants.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/controller/chat_function/chat_methods.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/chats/messages.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class VendorChatScrn extends StatelessWidget {
  VendorChatScrn({super.key});
  dynamic vid;
  @override
  Widget build(BuildContext context) {
Provider.of<VendorConnectionService>(context,listen: false).showList = Provider.of<VendorConnectionService>(context,listen: false).sortedVendors;
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor:const Color.fromARGB(255, 16, 81, 135) ,
        title: Text('Chat Screen', style: headText.copyWith(color: Colors.white)),
      ),
      body: Column(
        children: [
          ColoredBox(
            color: const Color.fromARGB(255, 16, 81, 135),
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
              builder: (context, value, child) =>value.sortedVendors!.length==0?Center(child:  Text('Chat List Not Found!',style: normalText,)): ListView.separated(
                separatorBuilder: (context, index) => Divider(),
              
                itemBuilder: (context, index) {
                  return
                   value.showList!.length != 0?
                   ListTile(
                   
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
                        radius:28,
                        backgroundImage:AssetImage("assets/splash/unknown.jpg")
                      ):CircleAvatar(
                        radius: 28,
                        backgroundImage:NetworkImage(value.showList![index].profilePhoto!)
                      ),
                      subtitle: Text(value.showList![index].email),
                      title: Text(value.showList![index].fullName,style: normalText,),
                      trailing:CircleAvatar(
                        child: IconButton(onPressed: (){
                         if(value.showList![index].phone!=null){ _makePhoneCall(value.showList![index].phone.toString());}else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Phone Details Empty")));
                         }
                        }, icon: Icon(Icons.phone)),
                      ) ,
                      
                      // trailing: value.connectionCount![index].count!=0? CircleAvatar(
                      //   radius: 9,
                      //   child: Text(
                      //     '${value.connectionCount![index].count}',
                      //     style: const TextStyle(fontSize: 12),
                      //   ),
                      // ):const SizedBox()
                    ):const Center(child: Text("No Chat Found!"),);
                  
                },
                
                itemCount: value.showList!.length,
              ),
            ),
          )
        ],
      ),
    );
  }
  void _makePhoneCall(String phoneNumber) async {
    try {
      await launchUrl(Uri.parse("tel://$phoneNumber)"));
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

}
