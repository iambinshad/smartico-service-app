import 'dart:developer';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/booking/booked_gigs_model.dart';

class ReservedGigsService {
  Dio dio = Dio();

  Future<List<BookedGigsModel>?>? fetchBookedGigs() async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.bookedGigs;
    String? token = await getUserAccesToken();

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        final List<BookedGigsModel> reservedGigs =
            (response.data["data"]["reserved"] as List)
                .map((e) => BookedGigsModel.fromJson(e))
                .toList();
        return reservedGigs;
    //      final data = json.decode(response.data["data"]["reserved"]);
    // return data;
      } 
    } on DioError catch (e) {
      log(e.message.toString());
      log('error');
    }
   return null;
  }
}
