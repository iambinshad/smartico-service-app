import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/controller/user/user_services.dart';
import 'package:smartico/model/user/usersign_req.dart';

import '../../model/user/user_sign_up_model.dart';
import '../../view/user/home/user_home.dart';
import '../../view/user/user_sign_in.dart';

class UserProvider with ChangeNotifier {
  bool userSignInPswdVisiblity = false;
  bool userSignUpPswdVisiblity = false;
  bool userSignUpConfPswdVisiblity = false;
  bool isLoading = false;
  var dateController = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? choosedGender;

  void changeSignInVisibleState(bool state) {
    userSignInPswdVisiblity = !state;
    notifyListeners();
  }

  void changeSignUpPswVisibleState(bool state) {
    userSignUpPswdVisiblity = !state;
    notifyListeners();
  }

  void changeSignUpConfPswVisibleState(bool state) {
    userSignUpConfPswdVisiblity = !state;
    notifyListeners();
  }

  void dropdownvalue(newValue) {
    choosedGender = newValue.toString();
    notifyListeners();
  }

  Future<void> checkUserSignIn(
      BuildContext context, emailData, passwordData) async {
    log('checkUserSing method inside');
    isLoading = true;
    final email = emailData;
    final password = passwordData;
    final signInUserDatas =
        UserSignInReqModel(password: email, email: password);
    log('after this');
    final tokenData = await UserServices().userSignIn(signInUserDatas, context);
    if (tokenData?.token != null) {
      // log(tokenData!.token.toString());
      storage.write(key: "token", value: jsonEncode(tokenData?.token));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const UserHomePage();
        },
      ), (route) => false);
      UserSignIn().disposeTextFiled();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> signUPNewUser(
      {context,
      fullName,
      userName,
      email,
      phone,
      password,
      conformPassword}) async {
        log(' inside signUPNewUser');
    final signUpUserDatas = UserSignUpModel(
      fullName: fullName,
      userName: userName,
      email: email,
      phone: phone,
      password: password,
      passwordConfirm: conformPassword,
    );

    final signUpResult = await UserServices().userSignUp(signUpUserDatas,context);
    if(signUpResult == 'User with this email already exists!!!' ){
      log('userService');
const emailExists = SnackBar(content: Text('Email Already Exists'));
      ScaffoldMessenger.of(context).showSnackBar(emailExists);
      log('userService Email Already Exists');

    }else {
      log('nextpage');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserHomePage(),));
    }
    return ;

  }
}
