import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/profile_page/user_profile_model.dart';

class UserProfileService {
  Dio dio = Dio();

  Future<UserProfileModel?>userProfile()async{
    String path = ApiConfigration.kBaseUrl+ApiConfigration.userProfile;
    String? token = await getUserAccesToken();
    try {
      Response response =await dio.get(path,options: Options(headers: {"Authorization":"Bearer $token"}));
      if(response.statusCode == 200){
        var jsonResponse = jsonDecode(jsonEncode(response.data['data']['profile']));
        var userDetails = UserProfileModel.fromJson(jsonResponse);

        return userDetails;
      }
      
    }on DioError catch (e) {
      log(e.message.toString());

    }
    return null;
  }
}