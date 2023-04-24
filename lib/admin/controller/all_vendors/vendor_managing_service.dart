import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smartico/admin/model/vendor_managing_model.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class VendorManagementService {
  Dio dio = Dio();

  Future<void> approveVendor(context, vendorId) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.admin +
        ApiConfigration.approveVendor;
    VendorApprovelModel id = VendorApprovelModel(id: vendorId);
    final token = getAdminAccesToken();

    try {
      Response response = await dio.post(path,
          data: jsonEncode(id.toJson()),
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Approving Vendor Successfull',
          ),
        );
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }

  Future<void> blockVendor(context, vendorId) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.admin +
        ApiConfigration.blockVendor;
    VendorBlockModel id = VendorBlockModel(id: vendorId);
    final token = getAdminAccesToken();

    try {
      Response response = await dio.post(path,
          data: jsonEncode(id.toJson()),
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Blocking Vendor Successfull',
          ),
        );
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
