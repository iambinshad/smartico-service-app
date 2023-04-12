import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_in_req_model.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_in_res_model.dart';

class VendorSignInApiService {
  Dio dio = Dio();
  Future<VendorSignInResModel?> vendorSignIn(
      VendorSignInReqModel vendorSignInReqModel, BuildContext context) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.vendorLogin;
    try {
      log('inside try');
      Response response =
          await dio.post(path, data: jsonEncode(vendorSignInReqModel.toJson()));
      log(response.toString());
      if (response.statusMessage == "Wrong Password") {
        if(context.mounted){
          Provider.of<CommonProvider>(context, listen: false)
            .userNotExist(context);
        }
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        if (response.data['token'] != null) {
          final VendorSignInResModel returnsignInResModel =
              VendorSignInResModel.fromJson(response.data);
          return returnsignInResModel;
        }
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
