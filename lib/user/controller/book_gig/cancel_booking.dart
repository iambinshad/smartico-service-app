import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/booking/cancel_booking.dart';


class CancelBookingService {
  Dio dio = Dio();

  Future<void> cancelBooking(context, CancelBookingModel gigId) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.cancelBooking;

    final token = await getUserAccesToken();

    try {
      Response response = await dio.patch(path,
          data: jsonEncode(gigId.toJson()),
          options: Options(headers: {"authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
   
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
   
  }
}
