import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/api/api_configration.dart';

class NewGigCreateApiService{
  Dio dio= Dio();
  Future<void>newGigCreate(gigCreateDatas)async{
    String path = ApiConfigration.kBaseUrl + ApiConfigration.vendor + ApiConfigration.newGIgCreate;
    FlutterSecureStorage storage =const FlutterSecureStorage();
    String? accesToken = await storage.read(key: 'VendorsignUpToken');
    String? token=accesToken!.replaceAll('"', '');

    try {  
      log('inside try');
      Response response = await dio.post(path,data:jsonEncode(gigCreateDatas.toJson(),),options: Options(headers:{"authorization": "Bearer $token"}) );
      if(response.statusCode == 401 || response.statusMessage =='failed'){
        log(response.statusCode.toString());
      }else if(response.statusCode == 200 || response.statusCode == 201){
        log('success');
          log(response.data['token']);
      }

    }on DioError catch (e) {
      
      log(e.message.toString());
    }
   
  }
}