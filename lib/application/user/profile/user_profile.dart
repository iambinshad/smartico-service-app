
import 'package:flutter/foundation.dart';
import 'package:smartico/user/controller/profile/profile_service.dart';
import 'package:smartico/user/model/profile_page/profile_edit_model.dart';
import 'package:smartico/user/model/profile_page/user_profile_model.dart';

class UserProfileProvider with ChangeNotifier{
  Future<UserProfileModel?>? userDetails;
  Future<void>getUserDetails()async{
     userDetails =   UserProfileService().userProfile() ;
  }

  Future<void>editUserProfile(UserProfileEditModel editData)async{
    UserProfileService().edituserProfile(editData);
    notifyListeners();
  }
}