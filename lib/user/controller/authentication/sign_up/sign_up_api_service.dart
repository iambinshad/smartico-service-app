import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';

import '../../../../core/api/api_configration.dart';
import '../../../model/authentication/user_sign_up_model.dart';
class UserSignUpApiService{
  Dio dio = Dio();
    Future<String> userSignUp(
      UserSignUpModel userSignUpModel, BuildContext context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.otp;
    try {
      Response response =
          await dio.post(path, data: jsonEncode(userSignUpModel.toJson()));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Provider.of<CommonProvider>(context, listen: false).userOtpSend(context);
        return 'Success';
      }
    } on DioError catch (e) {
      log(e.error.toString());
      Provider.of<CommonProvider>(context, listen: false)
          .userAlreadyExist(context);
    }

    return '';
  }

}