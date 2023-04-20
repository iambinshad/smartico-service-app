import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/vendor/model/complete_sign_up/complete_sign_up.dart';

class CompleteSignUPService {
  Dio dio = Dio();

  Future<String?> updateVendorAddress(VendorAddressModel address) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final vId = await storage.read(key: 'vendorId');
    String setAddressPath = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.setAddress +
        vId.toString();

    try {
      Response response =
          await dio.patch(setAddressPath, data: jsonEncode(address.toJson()));
      if (response.statusCode == 200) {
        log("updating Vendor address Success");
        return "success";
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }

  Future<String?> updateVendorSkill(VendorSkillsModel skill) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final vId = await storage.read(key: 'vendorId');
    String setSkillPath = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.setSkill +
        vId.toString();

    try {
      Response response =
          await dio.patch(setSkillPath, data: jsonEncode(skill.toJson()));
      if (response.statusCode == 200) {
        log("updating Vendor skills  Success");
        return "success";
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
