import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/booking/reveiw/add_reveiw_model.dart';

class AddReveiwService {
  Dio dio = Dio();
  Future<void> addReveiw(ReviewAddingModel reveiwData) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.addReveiw;
    final token = await getUserAccesToken();

    try {
      Response response = await dio.post(path,
          data: jsonEncode(reveiwData.toJson()),
          options: Options(headers: {"authorization": "Bearer $token"}));

          if(response.statusCode == 200){
            log("review adding success");
          }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
