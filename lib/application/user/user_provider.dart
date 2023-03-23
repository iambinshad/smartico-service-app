import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/controller/user/user_services.dart';
import 'package:smartico/model/user/usersignin_req.dart';
import 'package:smartico/view/user/user_otp.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../model/user/user_sign_up_model.dart';
import '../../model/user/user_sign_up_res.dart';
import '../../model/user/user_verify_otp.dart';
import '../../view/user/home/user_home.dart';
import '../../view/user/user_sign_in.dart';

class UserProvider with ChangeNotifier {
  bool userSignInPswdVisiblity = false;
  bool userSignUpPswdVisiblity = false;
  bool userSignUpConfPswdVisiblity = false;
  bool isLoading = false;
  bool isOtpValidator = true;
  var dateController = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? choosedGender;

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

  void dropdownvalue(newValue) {
    choosedGender = newValue.toString();
    notifyListeners();
  }

  Future<void> checkUserSignIn(
      BuildContext context, emailData, passwordData) async {
    isLoading = true;
    final email = emailData;
    final password = passwordData;
    final signInUserDatas =
        UserSignInReqModel(password: email, email: password);
    final tokenData = await UserServices().userSignIn(signInUserDatas, context);
    if (tokenData?.token != null) {
      storage.write(key: "signInToken", value: jsonEncode(tokenData?.token));

      // ignore: use_build_context_synchronously
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
    final signUpUserDatas = UserSignUpModel(
      fullName: fullName,
      userName: userName,
      email: email,
      phone: phone,
      password: password,
      passwordConfirm: conformPassword,
    );

    final signUpResult =
        await UserServices().userSignUp(signUpUserDatas, context);
    if (signUpResult == 'User with this email already exists!!!') {
    } else if (signUpResult == 'Success') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserOtpScreen(),
          ));
    }
    return;
  }

  Future verifyUserOtp(context, otpNumber) async {
    final otp = UserOtpVerifyModel(otp: int.parse(otpNumber));

    UserSignUpResModel? tokenData =
        await UserServices().userOtpVerification(otp, context);

    log(tokenData.toString());
    if (tokenData != null) {
      storage.write(key: 'signUpToken', value: jsonEncode(tokenData.token));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const UserHomePage();
        },
      ), (route) => false);
      
    }
   
  }

  void showSuccessSnackBar(context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: 'Congrats..OTP Verification Success',
      ),
    );
  }

  void showInvalidOtpSnack(context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Invalid OTP Entered',
      ),
    );
  }

  void showSomethingWentWrongSnack(context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.info(
        message: 'Something Went Wrong!',
      ),
    );
  }

  void userNotExist(context,) {
     showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Incorrect Username Or Password',
      ),
    );
  }
   void userAlreadyExist(context,) {
     showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'User With This Email Already Exist',
      ),
    );
  }
   void userOtpSend(context,) {
     showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: 'OTP sended',
      ),
    );
  }
}
