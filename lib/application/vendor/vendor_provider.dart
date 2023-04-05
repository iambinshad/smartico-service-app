
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/vendor/controller/authentication/otp_verification/vendor_otp_veriy.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_up_model.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_up_res.dart';
import 'package:smartico/vendor/model/authentication/vendor_verify_otp.dart';
import 'package:smartico/vendor/view/authentication/vendor_otp.dart';
import 'package:smartico/vendor/view/bottom_nav/vendor_bottom_nav.dart';
import '../../user/view/authentication/user_sign_in.dart';
import '../../vendor/controller/authentication/sign_in/sign_in_api_service.dart';
import '../../vendor/controller/authentication/sign_up/sign_up_api_service.dart';
import '../../vendor/model/authentication/vendor_sign_in_req_model.dart';

class VendorProvider extends ChangeNotifier {
  var dateController = TextEditingController();
  String? chooseGender;
  String? chooseType;
  String? chooseCatogory;
 
  
  FlutterSecureStorage storage = const FlutterSecureStorage();


//----Vendor Authentification Mehtods----//

 // VendorSignIn Method
  Future<void> checkVendorSignIn(
      BuildContext context, emailData, passwordData) async {
    
    final email = emailData;
    final password = passwordData;
    final signInVendorDatas =
        VendorSignInReqModel(password: password, email: email);
        log(signInVendorDatas.toString());
    final tokenData = await VendorSignInApiService().vendorSignIn(signInVendorDatas, context);
    log(tokenData.toString());
    if (tokenData != null) {
      await storage.write(key: "VendorsignInToken", value: jsonEncode(tokenData.token));
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const VendorBottomNavBar();
        },
      ), (route) => false);
      UserSignIn().disposeTextFiled();
    }
    
    notifyListeners();
  }

// Vendor Sign Up Method
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

// Vendor Otp Verification Method
  Future<void> verifyVendorOtp(context , otpNumber)async{

    final otp = VendorOtpVerifyModel(otp:int.parse(otpNumber));

    VendorSignUpResModel? tokenData = await VendorOtpVerifyApiService().VendorOtpVerification(otp, context);
    log(tokenData.toString());
    if(tokenData != null){
      await storage.write(key: 'VendorsignUpToken', value: jsonEncode(tokenData.token));
      await storage.write(key: 'vendorId', value: tokenData.data.user.id);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return   VendorBottomNavBar();
        },
      ), (route) => false);

    }
  }


//----Vendor Additional Methods----//
  void dropdownvalue(newValue,item) {

    if(item==1){
      chooseGender = newValue.toString();
    }else if(item == 2){
      chooseType =newValue.toString();
    }else if(item == 3){
      chooseCatogory =newValue.toString();
    }
    notifyListeners();
  }
}
