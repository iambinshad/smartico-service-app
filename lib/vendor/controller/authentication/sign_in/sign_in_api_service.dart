import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';

import '../../../../core/api/api_configration.dart';
import '../../../model/authentication/vendor_sign_in_req_model.dart';
import '../../../model/authentication/vendor_sign_in_res_model.dart';

class VendorSignInApiService{
  Dio dio = Dio();

   Future<VendorSignInResModel?> vendorSignIn(
      VendorSignInReqModel userSignInReqModel, BuildContext context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.vendor + ApiConfigration.vendorLogin;
    try {
      Response response =
          await dio.post(path, data: jsonEncode(userSignInReqModel.toJson()));
      log(response.toString());
      if (response.statusMessage != "Success") {
        // ignore: use_build_context_synchronously
        Provider.of<CommonProvider>(context, listen: false).userNotExist(context);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        final VendorSignInResModel returnsignInResModel =
            VendorSignInResModel.fromJson(response.data);
        return returnsignInResModel;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}