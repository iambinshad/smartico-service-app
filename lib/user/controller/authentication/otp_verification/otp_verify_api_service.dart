import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';

import '../../../../application/user/user_provider.dart';
import '../../../../core/api/api_configration.dart';
import '../../../model/authentication/user_sign_up_res.dart';
import '../../../model/authentication/user_verify_otp.dart';
class UserOtpVerifyApiService{
    Dio dio = Dio();
    Future<UserSignUpResModel?> userOtpVerification(
      UserOtpVerifyModel otp, context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.verifyOtp;

    try {
      log('inside try ');
      Response response = await dio.post(path, data: jsonEncode(otp.toJson()));
      log(response.toString());
      if (response.statusCode == 401) {
        log(response.statusCode.toString());
        Provider.of<CommonProvider>(context, listen: false)
            .showInvalidOtpSnack(context);
        return null;
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        log('success');
        if (response.data['token'] != null) {
          Provider.of<CommonProvider>(context, listen: false)
              .showSuccessSnackBar(context);
          log(response.data['token']);
          final UserSignUpResModel returnsignUpResModel =
              UserSignUpResModel.fromJson(response.data);
          log(returnsignUpResModel.token);
          return returnsignUpResModel;
        }

        return null;
      }
      Provider.of<CommonProvider>(context, listen: false)
          .showSomethingWentWrongSnack(context);
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}