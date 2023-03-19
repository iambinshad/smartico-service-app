import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/controller/user/user_services.dart';
import 'package:smartico/model/user/usersign_req.dart';

import '../../view/user/home/user_home.dart';
import '../../view/user/user_sign_in.dart';

class UserProvider with ChangeNotifier{

  bool userSignInPswdVisiblity = false;
  bool userSignUpPswdVisiblity = false;
  bool userSignUpConfPswdVisiblity = false;
  bool isLoading = false;
  var dateController = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
   String? choosedGender;

  void changeSignInVisibleState(bool state){
    userSignInPswdVisiblity = !state;
    notifyListeners();
  }
  void changeSignUpPswVisibleState(bool state){
    userSignUpPswdVisiblity = !state;
    notifyListeners();
  }
  void changeSignUpConfPswVisibleState(bool state){
    userSignUpConfPswdVisiblity = !state;
    notifyListeners();

  }
  void dropdownvalue(newValue){
    choosedGender = newValue.toString();
    notifyListeners();
  }

   Future<void>checkUserSignIn(BuildContext context ,emailData,passwordData)async{
    log('checkUserSing method inside');
    isLoading = true;
    final email = emailData ;
    final password = passwordData;
    final signInUser = UserSignInReqModel(password: email,email: password);
    log('after this');
    final tokenData = await UserServices().userSignIn(signInUser, context);
    if(tokenData?.token != null){
        // log(tokenData!.token.toString());
        storage.write(key: "token", value: jsonEncode(tokenData?.token));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          return const UserHomePage();
        },), (route) => false);
        UserSignIn().disposeTextFiled();

      }
    isLoading = false;
    notifyListeners();

  }
  
}