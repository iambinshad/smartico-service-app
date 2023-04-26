import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartico/admin/controller/all_vendors/all_vendors_service.dart';
import 'package:smartico/admin/controller/all_vendors/vendor_managing_service.dart';
import 'package:smartico/admin/model/catogory/vendors_details/all_vendor_details.dart';

class AllVendorListForAdmin with ChangeNotifier{
  List<AllVendorsByAdmin?>?allVendors;
String? result; 
  Future<void>fetchAllVendors()async{
    FetchAllVendorsDetails().fetchAllVendorsDetails().then((value){
      allVendors = value;
      log(allVendors.toString(),name: 'allvendors');
    });
  }

  Future<void>approveVendor(vendorId)async{
    result = await VendorManagementService().approveVendor(vendorId);
   
      notifyListeners();
     
  }
}