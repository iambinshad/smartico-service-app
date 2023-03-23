import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/user_provider.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/model/user/usersignin_req.dart';
import 'package:smartico/model/user/usersignin_res.dart';

import '../../model/user/user_sign_up_model.dart';
import '../../model/user/user_sign_up_res.dart';
import '../../model/user/user_verify_otp.dart';

class UserServices {
  Dio dio = Dio();

  Future<UserSignInResModel?> userSignIn(
      UserSignInReqModel userSignInReqModel, BuildContext context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.login;

    try {
      
      Response response =
          await dio.post(path, data: jsonEncode(userSignInReqModel.toJson()));
          log(response.toString());

      if (response.statusMessage != "Success") {
        Provider.of<UserProvider>(context, listen: false).userNotExist(context);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        final UserSignInResModel returnsignInResModel =
            UserSignInResModel.fromJson(response.data);
        return returnsignInResModel;
      }
    } on DioError catch (e) {
      log('catch');
      log(e.message.toString());
    }
    return null;
  }

  Future<String> userSignUp(
      UserSignUpModel userSignUpModel, BuildContext context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.otp;

    try {
      Response response = await dio.post(path, data: jsonEncode(userSignUpModel.toJson()));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
         Provider.of<UserProvider>(context, listen: false).userOtpSend(context);
        return 'Success';
      }
    } on DioError catch (e) {
       Provider.of<UserProvider>(context, listen: false).userAlreadyExist(context);
    }

    return '';
  }

  Future<UserSignUpResModel?> userOtpVerification(
      UserOtpVerifyModel otp, context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.verifyOtp;

    try {
      log('inside try ');
      Response response = await dio.post(path, data: jsonEncode(otp.toJson()));
      log(response.toString());
      if (response.statusCode == 401) {
        log(response.statusCode.toString());
        Provider.of<UserProvider>(context, listen: false)
            .showInvalidOtpSnack(context);
        return null;
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        log('success');
        if (response.data['token'] != null) {
          Provider.of<UserProvider>(context, listen: false)
              .showSuccessSnackBar(context);
          log(response.data['token']);
          final UserSignUpResModel returnsignUpResModel =
              UserSignUpResModel.fromJson(response.data);
          log(returnsignUpResModel.token);
          return returnsignUpResModel;
        }

        return null;
      }
      Provider.of<UserProvider>(context, listen: false)
          .showSomethingWentWrongSnack(context);
    } on DioError catch (e) {
      log('catch');
      log(e.message.toString());
    }
    return null;
  }

  // void dioError(Object e, BuildContext context) {

  //   if (e is DioError) {
  //     if (e.response?.statusCode == 404) {
  //       Provider.of<UserProvider>(context,listen: false).showSomethingWentWrongSnack(context);
  //     } else if (e.response?.statusCode == 401) {
  //      Provider.of<UserProvider>(context,listen: false).showInvalidOtpSnack(context);
  //     }
  //   }
  // }
}
