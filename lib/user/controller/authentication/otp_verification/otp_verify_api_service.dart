import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';

import '../../../../core/api/api_configration.dart';
import '../../../model/authentication/user_sign_up_res.dart';
import '../../../model/authentication/user_verify_otp.dart';
class UserOtpVerifyApiService{
    Dio dio = Dio();
    FlutterSecureStorage storage = const FlutterSecureStorage();
    Future<UserSignUpResModel?> userOtpVerification(
      UserOtpVerifyModel otp, context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.verifyOtp;

    try {
      log('inside try ');
      Response response = await dio.post(path, data: jsonEncode(otp.toJson()));
      log(response.toString());
      if (response.statusCode == 401) {
         Provider.of<CommonProvider>(context,listen: false).offLoading();
        log(response.statusCode.toString());
        Provider.of<CommonProvider>(context, listen: false)
            .showInvalidOtpSnack(context);
        return null;
      } else if (response.statusCode == 200 || response.statusCode == 201) {
         Provider.of<CommonProvider>(context,listen: false).offLoading();
            await storeCurrentDetails(response);
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
      
    } on DioError catch (e) {
       Provider.of<CommonProvider>(context,listen: false).offLoading();
        Provider.of<CommonProvider>(context, listen: false)
            .showInvalidOtpSnack(context);
      log(e.message.toString());
    }
    return null;
  }
  
  storeCurrentDetails(Response response) async{
      final data = response.data['data']['user'];
        final id = data['_id'];
        final name = data['fullName'];
        await storage.write(key: 'currentUserName', value: name);
        await storage.write(key: 'currentUserId', value: id);
  }
}