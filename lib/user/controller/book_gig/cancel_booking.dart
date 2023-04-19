import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/booking/cancel_booking.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Booking Canceling Successfull',
          ),
        );
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
   
  }
}
