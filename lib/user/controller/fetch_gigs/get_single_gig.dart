import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/user/model/show_all_gigs/show_single_gig.dart/show_single_gig_model.dart';

class ShowSingleGigService {
  Dio dio = Dio();
  Future<ShowSingleGigDetailsModel?> fetchGig(gigId) async {
    String path =
        ApiConfigration.kBaseUrl + ApiConfigration.getSingleGigDetails + gigId;

    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? accesToken = await storage.read(key: 'UsersignInToken');
    String? token = accesToken!.replaceAll('"', '');
    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
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
