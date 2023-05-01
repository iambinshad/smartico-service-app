import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/vendor/model/profile/edit_profile_model.dart';
import 'package:smartico/vendor/model/profile/vendor_profile_model.dart';

class VendorProfileService {
  Dio dio = Dio();

  Future<VendorProfileModel?> vendorProfile() async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.vendorProfile;
    String? token = await getVendorAccesToken();
    try {
      Response response = await dio.get(path,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        var jsonResponse =
            jsonDecode(jsonEncode(response.data['data']['profile']));
        var vendorDetails = VendorProfileModel.fromJson(jsonResponse);

        return vendorDetails;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }

  Future<void> editVendorProfile(EditVendorProfileModel editData) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.updateVendorProfile;
    String? token = await getVendorAccesToken();
    try {
      Response response = await dio.patch(path,
          data: jsonEncode(editData.toJson()),
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        log('profile editing successful');
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
