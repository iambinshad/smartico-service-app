import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:smartico/vendor/controller/profile/vendor_profile.dart';
import 'package:smartico/vendor/model/profile/vendor_profile_model.dart';

class  VendorProfileProvider  with ChangeNotifier{

  Future<VendorProfileModel?>? vendorDetails;

  Future<void>getVendorDetails()async{
    vendorDetails = VendorProfileService().vendorProfile();
    log(vendorDetails.toString(),name: 'vendoreeeeeeeeeeeeeeeeeee');
  }

}