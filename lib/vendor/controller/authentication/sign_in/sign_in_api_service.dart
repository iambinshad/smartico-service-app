import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import '../../../../core/api/api_configration.dart';
import '../../../model/authentication/vendor_sign_in_req_model.dart';
import '../../../model/authentication/vendor_sign_in_res_model.dart';
import '../../../view/home/vendor_home.dart';

class VendorSignInApiService{
  Dio dio = Dio();

   Future<VendorSignInResModel?> vendorSignIn(
      VendorSignInReqModel userSignInReqModel, BuildContext context) async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.vendor + ApiConfigration.vendorLogin;
    try {
      Response response =
          await dio.post(path, data: jsonEncode(userSignInReqModel.toJson()));
      log(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final VendorSignInResModel returnsignInResModel =
            VendorSignInResModel.fromJson(response.data);
        return returnsignInResModel;
        
      } else if (response.statusMessage=="Wrong Password") {
        Provider.of<CommonProvider>(context, listen: false).userNotExist(context);
      }
    } on DioError catch (e) {
      log(e.message.toString());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const VendorHomeScreen();
        },
      ), (route) => false);
    }
    return null;
  }
}