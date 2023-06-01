import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/show_all_gigs/vendor_all_gigs/personalised_gigs.dart';

class FetchVendorAllGigs {
  Dio dio = Dio();

  Future<List<PersonalisedGigsModel>?> fetch(String vendorId) async {
    String path =
        ApiConfigration.kBaseUrl + ApiConfigration.vendorAllGigs + vendorId;
    final token = await getUserAccesToken();

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        log(response.data.toString());
        final List<PersonalisedGigsModel> allGigs =
            (response.data["data"]["viewGig"] as List)
                .map((e) => PersonalisedGigsModel.fromJson(e))
                .toList();
        return allGigs;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
