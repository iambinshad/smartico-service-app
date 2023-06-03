
import 'package:flutter/cupertino.dart';
import 'package:smartico/vendor/controller/profile/vendor_profile.dart';
import 'package:smartico/vendor/model/profile/edit_profile_model.dart';
import 'package:smartico/vendor/model/profile/vendor_profile_model.dart';

class  VendorProfileProvider  with ChangeNotifier{

  Future<VendorProfileModel?>? vendorDetails;

  Future<void>getVendorDetails()async{
    vendorDetails = VendorProfileService().vendorProfile();
    notifyListeners();
  }

  Future<void>editVendorProfile(EditVendorProfileModel editData)async{
    VendorProfileService().editVendorProfile(editData);
    notifyListeners();
  }

}