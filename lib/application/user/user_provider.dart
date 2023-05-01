import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/common/roll_selecting.dart';
import 'package:smartico/user/model/authentication/usersignin_req.dart';
import 'package:smartico/user/view/authentication/user_otp.dart';
import 'package:smartico/user/view/bottom_nav/bottom_nav.dart';
import '../../user/controller/authentication/otp_verification/otp_verify_api_service.dart';
import '../../user/controller/authentication/sign_in/sign_in_api_service.dart';
import '../../user/controller/authentication/sign_up/sign_up_api_service.dart';
import '../../user/model/authentication/user_sign_up_model.dart';
import '../../user/model/authentication/user_sign_up_res.dart';
import '../../user/model/authentication/user_verify_otp.dart';
import '../../user/view/authentication/user_sign_in.dart';

class UserProvider with ChangeNotifier {
  bool userSignInPswdVisiblity = false;
  bool userSignUpPswdVisiblity = false;
  bool userSignUpConfPswdVisiblity = false;
  bool isLoading = false;
  bool isLoadingsignUp = false;
  bool isLoadingOtp = false;
  bool isOtpValidator = true;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  //----User Authentication Mehtods----//

  // UserSignIn Method
  Future<void> checkUserSignIn(
      BuildContext context, emailData, passwordData) async {
    isLoading = true;
    notifyListeners();
    final email = emailData;
    final password = passwordData;
    final signInUserDatas =
        UserSignInReqModel(password: email, email: password);
    final tokenData =
        await UserSignInApiService().userSignIn(signInUserDatas, context);

    if (tokenData?.token != null) {
      await storage.write(
          key: "user_access_token", value: jsonEncode(tokenData?.token));

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const UserBottomNavBar();
        },
      ), (route) => false);
      UserSignIn().disposeTextFiled();
    }
        isLoading = false;
    notifyListeners();
  }

// User Sign Up Method
  Future<void> signUPNewUser(
      {context,
fullName,
userName,
email,
phone,
password,
conformPassword}) async {
    isLoadingsignUp = true;
    notifyListeners();
    final signUpUserDatas = UserSignUpModel(fullName: fullName,userName: userName,email: email,phone: phone,password: password,passwordConfirm: conformPassword);

    final signUpResult =
        await UserSignUpApiService().userSignUp(signUpUserDatas, context);

    if (signUpResult == 'Success') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserOtpScreen(),
          ));  
    }
    isLoadingsignUp = false;
    notifyListeners();
  }

// User Otp Verification Method
  Future verifyUserOtp(context, otpNumber) async {
    isLoadingOtp = true;
    notifyListeners();
    final otp = UserOtpVerifyModel(otp: int.parse(otpNumber));

    UserSignUpResModel? tokenData =
        await UserOtpVerifyApiService().userOtpVerification(otp, context);

    log(tokenData.toString());
    if (tokenData != null) {
      await storage.write(
          key: 'user_access_token', value: jsonEncode(tokenData.token));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const RollSelectingScreen();
        },
      ), (route) => false);
    }
    isLoadingOtp = false;
    notifyListeners();
  }

  //----User Additional Methods----//

  void changeValidatorState() {
    isOtpValidator = !isOtpValidator;
    notifyListeners();
  }

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
}
