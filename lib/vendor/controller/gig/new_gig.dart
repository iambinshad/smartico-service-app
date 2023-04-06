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
        log(response.data.toString());
        return response.statusMessage;
      } else if (response.statusCode == 401 ||
          response.statusMessage == 'failed') {
        log(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }

  Future<List<CategoryResModel>?> getAllCategory(context) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.vendor +
        ApiConfigration.getallCategories;
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? accesToken = await storage.read(key: 'VendorsignUpToken');
    String? token = accesToken!.replaceAll('"', '');

    try {
      Response response = await dio.get(path,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        
        

        final List<CategoryResModel> category =
            (response.data['data']['categories'] as List)
                .map((e) => CategoryResModel.fromJson(e))
                .toList();
      
        return category;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
