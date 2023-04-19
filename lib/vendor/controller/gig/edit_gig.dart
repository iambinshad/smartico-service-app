import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';

class EditGigService {

  Dio dio = Dio();
   Future<dynamic> editGig(gigEditDatas) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.editGig;
    final token = await getVendorAccesToken();


    try {
      log('inside try');
      Response response = await dio.patch(path,
          data: jsonEncode(
            gigEditDatas.toJson(),
          ),
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return response.statusMessage;
      } else if (response.statusCode == 401 ||
          response.statusMessage == 'failed') {
        log(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }

}