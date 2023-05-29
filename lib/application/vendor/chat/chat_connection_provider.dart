import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/vendor/model/chat/vendor_chat_connection.dart';

class VendorConnectionService with ChangeNotifier {
  List<SortedVendor>? sortedVendors ;
  List<ConnectionCountV>? connectionCount;
  List<SortedVendor>? showList = [];
  Dio dio = Dio();

  Future<VendorChatListModel?> vendorConnection() async {
     final currentVendor = await  getCurrentVendorId();
     final token = await getVendorAccesToken();
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.getVendorConnections +
        currentVendor;

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Beared $token"}));
      if (response.statusCode == 200) {
         notifyListeners();
        log(response.data.toString(),name: "chatlisttttttttttttttttttttttttttttttt");
        Map<String, dynamic> responseData = response.data;
        var vendorChatListModel = VendorChatListModel.fromJson(responseData);
        sortedVendors = vendorChatListModel.sortedUsers;
        connectionCount = vendorChatListModel.connectionCount;
      }
    } on DioError catch (e) {
      log(e.message.toString(), name: "Vendor error");
    }
    return null;
  }
    void filterChatList(String enteredText) {
    List<SortedVendor>? filteredList = [];

    if (enteredText.isEmpty) {
      filteredList = sortedVendors;
    } else {
      filteredList = sortedVendors!
          .where((element) =>
              element.fullName.toLowerCase().contains(enteredText.toString()))
          .toList();
    }
    showList = filteredList;
    notifyListeners();
  }
}
