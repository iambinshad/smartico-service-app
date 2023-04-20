import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/admin/model/catogory/vendors_details/all_vendor_details.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';

class FetchAllVendorsDetails {
  Dio dio = Dio();
  Future<List<AllVendorsByAdmin>?> fetchAllVendorsDetails() async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.admin +
        ApiConfigration.fetchAllVendors;
    String? token = await getAdminAccesToken();

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        final List<AllVendorsByAdmin> allVendors =
            (response.data["data"]["vendors"] as List)
                .map((e) => AllVendorsByAdmin.fromJson(e))
                .toList();
                log(allVendors.toString());

      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
