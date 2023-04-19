import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/core/api/api_configration.dart';
import '../../model/catogory/catogory_req.dart';

class CategoryService {
  Dio dio = Dio();

  Future<void> categoryCreate(CatogoryReqModel newCatorgoryName) async {
    String path = ApiConfigration.kBaseUrl +
        ApiConfigration.admin +
        ApiConfigration.addCategory;

    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'admin_access_token');
    String? tokenData = token!.replaceAll('"', '');
    log(tokenData);
    try {
      Response response = await dio.post(path,
          data: jsonEncode(newCatorgoryName.toJson()),
          options: Options(headers: {"authorization": "Bearer $tokenData"}));
      log(response.data.toString());
    } on DioError catch (e) {
      log(e.message.toString());
    }
  }
}
