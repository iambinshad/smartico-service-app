import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DeleteGigService {
  Dio dio = Dio();

  Future<void> deleteGig(gigId, context) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.deleteGig +
        gigId;
    final token = await getVendorAccesToken();

    try {
      Response response = await dio.delete(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        log('success');
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Gig Delete Successfull',
          ),
        );
      } else {
        log(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
