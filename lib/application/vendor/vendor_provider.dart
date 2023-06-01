
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/vendor/controller/authentication/otp_verification/vendor_otp_veriy.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_in_res_model.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_up_model.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_up_res.dart';
import 'package:smartico/vendor/model/authentication/vendor_verify_otp.dart';
import 'package:smartico/vendor/view/authentication/vendor_otp.dart';
import 'package:smartico/vendor/view/bottom_nav/vendor_bottom_nav.dart';
import 'package:smartico/vendor/view/vendor_approve_screen/vendor_approve_scrn1.dart';
import '../../user/view/authentication/user_sign_in.dart';
import '../../vendor/controller/authentication/sign_in/sign_in_api_service.dart';
import '../../vendor/controller/authentication/sign_up/sign_up_api_service.dart';
import '../../vendor/model/authentication/vendor_sign_in_req_model.dart';

class VendorProvider extends ChangeNotifier {
  var dateController = TextEditingController();
  String? chooseGender;
  String? chooseType;
  String? chooseCatogory;

  bool isLoading = false;
  bool isLoadingsignup = false;
  bool isLoadingOtp = false;
 
  FlutterSecureStorage storage = const FlutterSecureStorage();


//----Vendor Authentification Mehtods----//

 // VendorSignIn Method
  Future<void> checkVendorSignIn(
      BuildContext context, emailData, passwordData) async {
        isLoading = true;
        notifyListeners();
    
    final email = emailData;
    final password = passwordData;
    final signInVendorDatas =
        VendorSignInReqModel(password: password, email: email);
       
    VendorSignInResModel? tokenData = await VendorSignInApiService().vendorSignIn(signInVendorDatas, context);
    if (tokenData != null) {
      log(tokenData.token.toString(),name: "VendorTokennnnnnnn");
      await storage.write(key: "vendor_access_token", value: jsonEncode(tokenData.token));
            await storage.write(key: 'vendorId', value: tokenData.data!.user.id);

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const VendorBottomNavBar();
        },
      ), (route) => false);
      UserSignIn().disposeTextFiled();
    }
    isLoading = false;
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
        isLoadingsignup = true;
        notifyListeners();
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
    final signUpResult = await VendorSignUpApiService().vendorSignUp(signUpVendorDatas, context);
    log(signUpResult.toString());
    if(signUpResult == "success"){
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VendorOtpScreen(),), (route) => false);
    }
    isLoadingsignup = false;
    notifyListeners();
  }
  

// Vendor Otp Verification Method
  Future<void> verifyVendorOtp(context , otpNumber)async{
    isLoadingOtp = true;
    notifyListeners();

    final otp = VendorOtpVerifyModel(otp:int.parse(otpNumber));

    VendorSignUpResModel? tokenData = await VendorOtpVerifyApiService().vendorOtpVerification(otp, context);
    log(tokenData.toString());
    if(tokenData != null){
      log(tokenData.token);
      await storage.write(key: 'vendor_access_token', value: jsonEncode(tokenData.token));
      await storage.write(key: 'vendorId', value: tokenData.data.user.id);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return  const VendorApprovalFirstScrn();
        },
      ), (route) => false);

    }
    isLoadingOtp = false;
    notifyListeners();
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
