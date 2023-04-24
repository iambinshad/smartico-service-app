import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/booking/cancel_booking.dart';
import 'package:smartico/vendor/model/booking/new_bookings_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ShowAllBookingService {
  Dio dio = Dio();

  Future<List<AllBooking>?> showAllBookings() async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.allBookings;

    try {
      final token = await getVendorAccesToken();

      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Beared $token"}));
      if (response.statusCode == 200) {
        log(response.data.toString(), name: 'First');
        final List<AllBooking> allBookings =
            (response.data["vendorOrders"] as List)
                .map((e) => AllBooking.fromJson(e))
                .toList();
        return allBookings;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }

  Future<void> completeService(context, CompleteBookingModel gigId) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.completeService;
    final token = await getVendorAccesToken();
    try {
      Response response = await dio.patch(path,
          data: jsonEncode(gigId.toJson()),
          options: Options(headers: {"authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        log('success');
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }

  Future<void> listAllCompletedServices(context) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.completedOrderByData;
    final token = await getVendorAccesToken();

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {}
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
