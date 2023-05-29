import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/user/model/booking/cancel_booking.dart';
import 'package:smartico/vendor/model/booking/new_bookings_model.dart';

class ShowAllBookingService {
  Dio dio = Dio();
Future<List<AllOrders>?> showAllBookings() async {
  String path = ApiConfigration.kBaseUrl +
      ApiConfigration.vendor +
      ApiConfigration.allOrders;

  try {
    final token = await getVendorAccesToken();

    Response response = await dio.get(
      path,
      options: Options(headers: {"authorization": "Bearer $token"}),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data["data"]["reserved"];
      log(response.data.toString());
      List<AllOrders> allOrdersList = [];

      for (var json in responseData) {
        AllOrders allOrders = AllOrders.fromJson(json);
        allOrdersList.add(allOrders);
      }

      log(allOrdersList.toString());

      return allOrdersList;
    }
  } on DioError catch (e) {
    log(e.message.toString());
  }
  
  return null;
}
  // Future<List<Reserved>?> showAllBookings() async {
  //   String path = ApiConfigration.kBaseUrl +
  //       ApiConfigration.vendor +
  //       ApiConfigration.allOrders;

  //   try {
  //     final token = await getVendorAccesToken();

  //     Response response = await dio.get(path,
  //         options: Options(headers: {"authorization": "Beared $token"}));
  //     if (response.statusCode == 200) {
  //       List<dynamic> responseee = response.data["data"]["reserved"];

   
  //       return reservedList;
  //     }
  //   } on DioError catch (e) {
  //     log(e.message.toString());
  //   }
  //   return null;
  // }

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
