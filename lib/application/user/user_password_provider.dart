import 'package:flutter/material.dart';



class UserPasswordProvider extends ChangeNotifier{

  bool userSignInPswdVisiblity = false;
  bool userSignUpPswdVisiblity = false;
  bool userSignUpConfPswdVisiblity = false;
  var dateController = TextEditingController();
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

}