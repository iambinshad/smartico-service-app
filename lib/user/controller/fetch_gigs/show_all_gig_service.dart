import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/user/model/show_all_gigs/gig_model.dart';

class ShowAllGigsService {
  Dio dio = Dio();

  Future<List<ShowAllGigsToUserModle>?> showAllGigs() async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.fetchAllGigs;
    try {
      Response response = await dio.get(path);
      if (response.statusCode == 200) {
        final List<ShowAllGigsToUserModle> allGigs =
            (response.data["data"]['allGigs'] as List)
                .map((e) => ShowAllGigsToUserModle.fromJson(e))
                .toList();
                return allGigs;
      }
    }on DioError catch (e) {
      log(e.message.toString());
      log('error');

    }
    return null;
  }
}
