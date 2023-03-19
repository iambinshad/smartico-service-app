import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/model/user/usersign_req.dart';
import 'package:smartico/model/user/usersign_res.dart';

class UserServices {

Dio dio = Dio();

Future<UserSignInResModel?>userSignIn(UserSignInReqModel userSignInReqModel ,BuildContext context )async{

String path = ApiConfigtration.kBaseUrl + ApiConfigtration.login;

try{
  log('inside try');
  Response response = await dio.post(path,data:jsonEncode(userSignInReqModel.toJson()) );
  
  // log(response.data.toString());
  if(response.statusCode == 200 || response.statusCode== 201){
    
    final UserSignInResModel returnsignInResModel =  UserSignInResModel.fromJson(response.data);
    return returnsignInResModel;
  }
}on DioError catch (e){
  dioError(e, context);
}
return null;

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