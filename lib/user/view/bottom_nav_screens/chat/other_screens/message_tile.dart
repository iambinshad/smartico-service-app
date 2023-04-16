import 'package:flutter/material.dart';

Widget message(
    {required Map model, required BuildContext context, required currentUserId}) {
  return Container(
      width: MediaQuery.of(context).size.width * 5,
      alignment: model["sendBy"] == currentUserId
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: model["sendBy"] == currentUserId
                ? const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))
                :const  BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
            color: Colors.blue),
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(model["message"]),
      ));
}
