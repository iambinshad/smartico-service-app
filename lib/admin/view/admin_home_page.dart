import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Center(child: ElevatedButton(onPressed: (){
      FlutterSecureStorage storage = const FlutterSecureStorage();
      storage.delete(key: 'AdminSignInToken');
    }, child: const Text('logout'))),);
  }
}