import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/model/user/usersign_req.dart';
import 'package:smartico/model/user/usersign_res.dart';

import '../../model/user/user_sign_up_model.dart';

class UserServices {

Dio dio = Dio();

Future<UserSignInResModel?>userSignIn(UserSignInReqModel userSignInReqModel ,BuildContext context )async{

String path = ApiConfigtration.kBaseUrl + ApiConfigtration.login;

try{

  log('inside try');
  Response response = await dio.post(path,data:jsonEncode(userSignInReqModel.toJson()) );
  
 
  
  if(response.statusCode == 200 || response.statusCode== 201){
    
    final UserSignInResModel returnsignInResModel =  UserSignInResModel.fromJson(response.data);
    return returnsignInResModel;
  }
}on DioError catch (e){
  dioError(e, context);
}
return null;

}

Future<String>userSignUp(UserSignUpModel userSignUpModel,BuildContext context)async{
  String path = ApiConfigtration.kBaseUrl+ApiConfigtration.otp;
  log('inside userSignUp');
  try{
    log('inside userSignUp');
    Response response = await dio.post(path,data:jsonEncode(userSignUpModel.toJson()));
    log(response.toString());
    if(response.statusCode == 200){
      log('success ==200');
      return response.data.toString();
    }else if(response.statusCode == 401){
      log('this email already exist');

      return 'User with this email already exists!!!';
    }
  }on DioError catch (e){
    dioError(e, context);
  log(e.message.toString());
  }

  return '';
}
  void dioError(Object e, BuildContext context) {
    const inCorrectEmailOrPassword = SnackBar(content: Text('InCorrect Email or Password'));
    if (e is DioError) {
      if (e.response?.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(inCorrectEmailOrPassword);
      } else if (e.response?.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(inCorrectEmailOrPassword);
      }
    }
  }


  
}