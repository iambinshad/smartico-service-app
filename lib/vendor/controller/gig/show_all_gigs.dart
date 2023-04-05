import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartico/core/api/api_configration.dart';
import 'package:smartico/vendor/model/show_all_gig/show_all_gig.dart';
import 'package:smartico/vendor/model/show_all_gig/vendor_id_model.dart';

class ShowAllGigs{
  Dio dio = Dio();

  

  Future<List<GigResModel>?>showAllGIgs()async{
FlutterSecureStorage storage =const FlutterSecureStorage();
  String? vendorId = await storage.read(key: 'vendorId');
  String vendorIdOrg = vendorId!.replaceAll('"', '');
  final accessToken =await storage.read(key: 'VendorsignUpToken');
  String? token = accessToken!.replaceAll('"', '');
  const path = ApiConfigration.kBaseUrl+ApiConfigration.vendor+ApiConfigration.showAllVendorGigs;

final vendorIdData = VendorIdModle(vendorId: vendorIdOrg);

  try {
    log('inside try');
    Response response = await dio.get(path,options:Options(headers: {"authorization":"Bearer $token"}),  );
    log(response.toString());
    if(response.statusCode == 200){
      
      final List<GigResModel>allGigsDatas = (response.data['data']['viewGig'] as List)
                .map((e) => GigResModel.fromJson(e))
                .toList();

                return allGigsDatas;

    }

  } catch (e) {
    
  }
  return null;


  }


}