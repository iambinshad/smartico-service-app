import 'package:flutter/material.dart';

Widget message(
    {required Map model, required BuildContext context, required currentId}) {
  return Container(
      width: MediaQuery.of(context).size.width * 5,
      alignment: model["sendBy"] == currentId
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: model["sendBy"] == currentId
                ? const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))
                :const  BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
            color: model["sendBy"] == currentId ?Colors.white:const Color.fromARGB(255, 96, 171, 232)),
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(model["message"]),
      ));
}
