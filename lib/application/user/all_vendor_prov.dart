import 'package:flutter/material.dart';
import 'package:smartico/user/controller/all_vendors/all_vendor_service.dart';
import 'package:smartico/user/model/all_vendors/all_vendor_model.dart';

class GetAllVendor with ChangeNotifier {
  List<AllVendorsModel>? allVendors = [];
  List<AllVendorsModel>? showList = [];

  Future<void> fetchAllVendors() async {
    ShowAllVendorsService().showAllVendors().then((value) {
      allVendors = value;
    });
  }

  void filterChatList(String enteredText) {
    List<AllVendorsModel>? filteredList = [];

    if (enteredText.isEmpty) {
      filteredList = allVendors;
    } else {
      filteredList = allVendors!
          .where((element) =>
              element.fullName!.toLowerCase().contains(enteredText.toString()))
          .toList();
    }
    showList = filteredList;
    notifyListeners();
  }
}
