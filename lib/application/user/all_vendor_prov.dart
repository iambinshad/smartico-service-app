import 'package:flutter/material.dart';
import 'package:smartico/user/controller/all_vendors/all_vendor_service.dart';
import 'package:smartico/user/model/all_vendors/all_vendor_model.dart';

class GetAllVendor with ChangeNotifier {
  List<AllVendorsModel>? allVendors = [];

  Future<void> fetchAllVendors() async {
    ShowAllVendorsService().showAllVendors().then((value) {
      allVendors = value;
    });
  }
}
