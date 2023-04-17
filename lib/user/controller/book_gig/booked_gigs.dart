import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/user/model/booking/booked_gigs_model.dart';

class ReservedGigsService {
  Dio dio = Dio();
  Future<List<BookedGigsModel>?> fetchBookedGigs() async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.bookedGigs;
   FlutterSecureStorage storage = const FlutterSecureStorage();
    String? accesToken = await storage.read(key: 'UsersignInToken');
    String? token = accesToken!.replaceAll('"', '');

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        final List<BookedGigsModel> reservedGigs =
            (response.data["data"]["reserved"] as List)
                .map((e) => BookedGigsModel.fromJson(e))
                .toList();
        return reservedGigs;
      } else {
        log('something went wrong');
      }
    } on DioError catch (e) {
      log(e.message.toString());
      log('error');
    }
    return null;
  }
}
