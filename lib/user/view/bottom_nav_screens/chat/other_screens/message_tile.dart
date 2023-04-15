import 'package:flutter/material.dart';
import 'package:smartico/user/model/chat/message_model.dart';

Widget message({required MessageModelTwo model,required BuildContext context ,required token}){
  
  return Container(
     alignment:model.sendBy == token?Alignment.centerLeft:Alignment.centerRight ,
    child: Column(
      children: [
        Text(model.message??""),
        Row(
          children: [
            // Text(DateFormat.jm().format)
            model.sendBy != token? const Icon(Icons.done_all):Text(''),
          ],
        )
      ],
    ),
  );
}