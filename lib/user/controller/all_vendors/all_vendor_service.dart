import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/user/model/all_vendors/all_vendor_model.dart';

class ShowAllVendorsService {
  
  Dio dio = Dio();

  Future<List<AllVendorsModel>?> showAllVendors() async {
    String path = ApiConfigration.kBaseUrl + ApiConfigration.getAllVendors;

    try {
      Response response = await dio.get(path);
      if (response.statusCode == 200) {
        final List<AllVendorsModel> allVendors =
            (response.data["data"]["allVendors"] as List)
                .map((e) => AllVendorsModel.fromJson(e))
                .toList();

        return allVendors;
      }
    } on DioError catch (e) {
      log(e.message.toString());
      log('error');
    }
    return null;
  }
}
