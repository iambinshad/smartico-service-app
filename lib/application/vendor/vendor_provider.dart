
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/vendor/controller/authentication/otp_verification/vendor_otp_veriy.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_up_model.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_up_res.dart';
import 'package:smartico/vendor/model/authentication/vendor_verify_otp.dart';
import 'package:smartico/vendor/view/authentication/vendor_otp.dart';
import 'package:smartico/vendor/view/home/vendor_home.dart';
import '../../user/view/authentication/user_sign_in.dart';
import '../../user/view/bottom_nav_screens/user_home.dart';
import '../../vendor/controller/authentication/sign_in/sign_in_api_service.dart';
import '../../vendor/controller/authentication/sign_up/sign_up_api_service.dart';
import '../../vendor/model/authentication/vendor_sign_in_req_model.dart';

class VendorProvider extends ChangeNotifier {
  var dateController = TextEditingController();
  String? choosedGender;
    FlutterSecureStorage storage = const FlutterSecureStorage();


//----User Authentification Mehtods----//

 // UserSignIn Method
  Future<void> checkVendorSignIn(
      BuildContext context, emailData, passwordData) async {
    
    final email = emailData;
    final password = passwordData;
    final signInVendorDatas =
        VendorSignInReqModel(password: email, email: password);
    final tokenData = await VendorSignInApiService().vendorSignIn(signInVendorDatas, context);
    if (tokenData?.token != null) {
      storage.write(key: "VendorsignInToken", value: jsonEncode(tokenData?.token));
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const UserHomePage();
        },
      ), (route) => false);
      UserSignIn().disposeTextFiled();
    }
    
    notifyListeners();
  }

// User Sign Up Method
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

// User Otp Verification Method
  Future<void> VerifyVendorOtp(context , otpNumber)async{

    final otp = VendorOtpVerifyModel(otp:int.parse(otpNumber));

    VendorSignUpResModel? tokenData = await VendorOtpVerifyApiService().VendorOtpVerification(otp, context);
    log(tokenData.toString());
    if(tokenData != null){
      storage.write(key: 'VendorsignUpToken', value: jsonEncode(tokenData.token));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return  const VendorHomeScreen();
        },
      ), (route) => false);

    }
  }


//----User Additional Methods----//
  void dropdownvalue(newValue) {
    choosedGender = newValue.toString();
    notifyListeners();
  }
}
