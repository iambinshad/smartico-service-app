import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/chat/message_provider.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/chat/chat_connection.dart';
import 'package:smartico/user/model/chat/message_model.dart';
import 'package:smartico/vendor/model/chat/vendor_chat_connection.dart';

class UserConnectionService with ChangeNotifier {
  List<SortedUser>? sortedUsers;
  List<SortedUser>? showList = [];
  List<ConnectionCount>? connectionCount;
  Dio dio = Dio();

  Future<void> userConnection() async {
    final currentUser = await getCurrentUserId();
    final token = await getUserAccesToken();
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.getUserConnections +
        currentUser;

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Beared $token"}));
      if (response.statusCode == 200) {
        notifyListeners();
        log(response.data.toString());
        Map<String, dynamic> responseData = response.data;
        var userChatListModel = UserChatListModel.fromJson(responseData);
        sortedUsers = userChatListModel.sortedUsers;
        connectionCount = userChatListModel.connectionCount;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
      void filterChatList(String enteredText) {
    List<SortedUser>? filteredList = [];

    if (enteredText.isEmpty) {
      filteredList = sortedUsers;
    } else {
      filteredList = sortedUsers!
          .where((element) =>
              element.fullName!.toLowerCase().contains(enteredText.toString()))
          .toList();
    }
    showList = filteredList;
    notifyListeners();
  }
}

class SendMessageService with ChangeNotifier {
  Dio dio = Dio();

  Future<void> sendMessageService(
      String? roleId, String? senderId, context) async {
    final prov = Provider.of<MessageProvider>(context, listen: false);
    String path = ApiConfigration.kBaseUrl + ApiConfigration.chat;
    if (prov.messageController.text.isNotEmpty) {
      MessageModel2 messageModel = MessageModel2(
          from: roleId, to: senderId, message: prov.messageController.text);
      try {
        Response response =
            await dio.post(path, data: jsonEncode(messageModel.tojson()));
        if (response.statusCode == 200) {
          notifyListeners();
          log(
            "Message Sending succussfull",
          );
        }
      } on DioError catch (e) {
        log(e.message.toString());
      }

      prov.messageController.clear();
    }
  }
}
