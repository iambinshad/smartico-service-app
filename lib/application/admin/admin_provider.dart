import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/admin/controller/authentication/sign_in/sign_in_api_service.dart';
import 'package:smartico/admin/model/admin_sign_in_req_model.dart';
import 'package:smartico/admin/view/admin_home_page.dart';
import 'package:smartico/application/common/common_provider.dart';
import '../../user/view/authentication/user_sign_in.dart';

class AdminProvider with ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> checkAdminSignIn(
      BuildContext context, emailData, passwordData) async {
    final email = emailData;
    final password = passwordData;
    final signAdminDatas =
        AdminSignInReqModel(email: email, password: password);
    final tokenData =
        await AdminSignInApiService().adminSignIn(signAdminDatas, context);
    if (tokenData?.token != null) {
      await storage.write(
          key: 'admin_access_token', value: jsonEncode(tokenData?.token));

      notifyListeners();

    if(context.mounted){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AdminPage(),
          ),
          (route) => false);
    }
    }
    UserSignIn().disposeTextFiled();
   if(context.mounted){
     Provider.of<CommonProvider>(context, listen: false).offLoading();
   }
  }
}
