
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/vendor/model/authentication/vendor_sign_up_res.dart';
import 'package:smartico/vendor/model/authentication/vendor_verify_otp.dart';

import '../../../../application/common/common_provider.dart';

class VendorOtpVerifyApiService{
  Dio dio = Dio();
  Future<VendorSignUpResModel?>VendorOtpVerification(VendorOtpVerifyModel otp,context)async{

    String path = ApiConfigration.kBaseUrl + ApiConfigration.vendor + ApiConfigration.verifyVendorOTP;

    try {
      log('inside try');
      Response response = await dio.post(path,data:jsonEncode(otp.toJson()) );

      if(response.statusCode == 401 || response.statusMessage =='failed'){
        log(response.statusCode.toString());
        Provider.of<CommonProvider>(context, listen: false)
            .showInvalidOtpSnack(context);
        return null;
      }else if(response.statusCode == 200 || response.statusCode == 201){
        log('success');
        
          Provider.of<CommonProvider>(context, listen: false)
              .showSuccessSnackBar(context);
          log(response.data['token']);
          final VendorSignUpResModel returnsignUpResModel =
              VendorSignUpResModel.fromJson(response.data);
              
          log(returnsignUpResModel.token);
          return returnsignUpResModel;
        
        
      }

    }on DioError catch (e) {
       Provider.of<CommonProvider>(context, listen: false)
            .showInvalidOtpSnack(context);
      log(e.message.toString());
    }
    return null;
  }
}