import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/booking/reveiw/get_gig_reveiw.dart';

class ReveiwService {
  Dio dio = Dio();
  Future<List<GIgReveiwModel>?> listReveiw(gigId) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.getReviews+gigId;
    final token = await getUserAccesToken();

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
       final List<GIgReveiwModel> reveiws =
            (response.data["data"]['review'] as List)
                .map((e) => GIgReveiwModel.fromJson(e))
                .toList();
                return reveiws;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
