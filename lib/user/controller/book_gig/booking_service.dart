import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/user/model/booking/booking_model.dart';

class BookingService {
  Dio dio = Dio();

  Future<void> bookingapiService(GigBookingModel bookingModel, context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.bookGig;
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? accesToken = await storage.read(key: 'user_access_token');
    String? token = accesToken!.replaceAll('"', '');

    try {
      Response response = await dio.post(path,
          data: jsonEncode(bookingModel.toJson()),
          options: Options(headers: {"authorization": "Bearer $token "}));

      if (response.statusCode == 200) {
        log('Booking successfull');
      }
    } on DioError catch (e) {
      log(e.message.toString());
      log('dioerror');
    }
  }
}
