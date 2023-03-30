import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import '../../../../core/api/api_configration.dart';
import '../../../model/authentication/usersignin_req.dart';
import '../../../model/authentication/usersignin_res.dart';

class UserSignInApiService {
  Dio dio = Dio();

  Future<UserSignInResModel?> userSignIn(
      UserSignInReqModel userSignInReqModel, BuildContext context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.login;
    try {
      Response response =
          await dio.post(path, data: jsonEncode(userSignInReqModel.toJson()));
      // log(response.statusMessage.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        Provider.of<CommonProvider>(context, listen: false).offLoading();
        final UserSignInResModel returnsignInResModel =
            UserSignInResModel.fromJson(response.data);
        return returnsignInResModel;
        // ignore: use_build_context_synchronously
      }
    } on DioError catch (e) {
      Provider.of<CommonProvider>(context, listen: false).offLoading();
      Provider.of<CommonProvider>(context, listen: false).userNotExist(context);
      log(e.message.toString());
    }
    return null;
  }
}
