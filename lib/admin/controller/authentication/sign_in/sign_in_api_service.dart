import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/core/api/api_configration.dart';
import '../../../../application/common/common_provider.dart';
import '../../../model/admin_sign_in_req_model.dart';
import '../../../model/admin_sign_in_res_model.dart';

class AdminSignInApiService {
  Dio dio = Dio();

  Future<AdminSignUpResModel?> adminSignIn(
      AdminSignInReqModel adminSignInReqModel, BuildContext context) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.admin +
        ApiConfigration.adminLogin;
    try {
      Response response =
          await dio.post(path, data: jsonEncode(adminSignInReqModel.toJson()));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Provider.of<CommonProvider>(context, listen: false).offLoading();
        final AdminSignUpResModel responseData =
            AdminSignUpResModel.fromJson(response.data);
        return responseData;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
