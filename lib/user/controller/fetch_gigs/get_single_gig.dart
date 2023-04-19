import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/show_all_gigs/show_single_gig.dart/show_single_gig_model.dart';

class ShowSingleGigService {
  Dio dio = Dio();
  Future<ShowSingleGigDetailsModel?> fetchGig(gigId,context) async {
    String path =
        ApiConfigration.kBaseUrl + ApiConfigration.getSingleGigDetails + gigId;

 
    String? token = await getUserAccesToken();
    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        Provider.of<CommonProvider>(context,listen: false).setShimmerLoading(false);
        log(response.data.toString());
       
var jsonResponse = jsonDecode(jsonEncode(response.data['data']['singleGig']));
var singleGigDetails = ShowSingleGigDetailsModel.fromJson(jsonResponse);

        return singleGigDetails;

      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
