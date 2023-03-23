
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_up_model.dart';
import 'package:smartico/vendor/view/authentication/vendor_otp.dart';

import '../../vendor/controller/authentication/sign_up/sign_up_api_service.dart';

class VendorProvider extends ChangeNotifier {
  var dateController = TextEditingController();
  String? choosedGender;

  Future<void> signUpNewVendor(
      {required fullName,
      required userName,
      required email,
      required phone,
      required gender,
      required dob,
      required password,
      required passwordConfirm,required context}) async {
    final signUpVendorDatas = VendorSignUpModel(
      fullName: fullName,
      userName: userName,
      email: email,
      phone: phone,
      gender: gender,
      dob: dob,
      password: password,
      passwordConfirm: passwordConfirm,
    );
log(signUpVendorDatas.toString());
    final signUpResult = await VendorSignUpApiService().VendorSignUp(signUpVendorDatas, context);
    log(signUpResult.toString());
    if(signUpResult == 'Vendor with this email already exists!!!'){
     log('Vendor with this email already exist!!');
    }else if(signUpResult == "success"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VendorOtpScreen(),), (route) => false);
    }
  }


//----User Additional Methods----//
  void dropdownvalue(newValue) {
    choosedGender = newValue.toString();
    notifyListeners();
  }
}
