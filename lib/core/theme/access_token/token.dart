import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> getUserAccesToken()async{
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? accesToken = await storage.read(key: 'user_access_token');
    String? token = accesToken!.replaceAll('"', '');
    return token;
}

Future<String> getCurrentUserId()async{
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? pId = await storage.read(key: 'currentUserId');
    String? id = pId!.replaceAll('"', '');
    return id;
}

Future<String>getCurrentUserName()async{
     FlutterSecureStorage storage = const FlutterSecureStorage();
    String? pId = await storage.read(key: 'currentUserName');
    String? id = pId!.replaceAll('"', '');
    return id;
}

Future<String>getCurrentVendorId()async{
     FlutterSecureStorage storage = const FlutterSecureStorage();
    String? pId = await storage.read(key: 'currentVendorId');
    String? id = pId!.replaceAll('"', '');
    return id;
}

Future<String> getVendorAccesToken()async{
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? accesToken = await storage.read(key: 'vendor_access_token');
    String? token = accesToken??"".replaceAll('"', '');
    return token;
}
