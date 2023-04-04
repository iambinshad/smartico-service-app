import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/vendor/model/category/get_all_category.dart';
import '../../../core/api/api_configration.dart';

class NewGigCreateApiService {
  Dio dio = Dio();
  Future<dynamic> newGigCreate(gigCreateDatas) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.newGIgCreate;
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? accesToken = await storage.read(key: 'VendorsignUpToken');
    String? token = accesToken!.replaceAll('"', '');

    try {
      log('inside try');
      Response response = await dio.post(path,
          data: jsonEncode(
            gigCreateDatas.toJson(),
          ),
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.statusMessage;
      } else if (response.statusCode == 401 ||
          response.statusMessage == 'failed') {
        log(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }

  Future<List<CatogoryResModel>?> getAllCategory(context) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.getallCategories;
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? accesToken = await storage.read(key: 'VendorsignUpToken');
    String? token = accesToken!.replaceAll('"', '');

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      log(response.data.toString());
      if (response.statusCode == 200) {
        log(response.data.toString());
        final List<CatogoryResModel> category = (response.data as List)
            .map((e) => CatogoryResModel.fromJson(e))
            .toList();
            return category;
  
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
    
  }
}
