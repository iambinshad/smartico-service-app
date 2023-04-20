import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/admin/controller/new_category/category_service.dart';
import 'package:smartico/admin/model/catogory/catogory_req.dart';
import 'package:smartico/application/admin/fetch_all_vendors/fetch_all_vendors_provider.dart';

class AdminPage extends StatelessWidget {
   AdminPage({super.key});
  
  final catagoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AllVendorListForAdmin>(context,listen: false).fetchAllVendors();
    });
    return SafeArea(
      child: Scaffold(body:  Column(
        children: [
          Center(child: ElevatedButton(onPressed: (){
            FlutterSecureStorage storage = const FlutterSecureStorage();
            storage.delete(key: 'admin_access_token');
          }, child: const Text('logout'))),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: catagoryController,
            ),
          ),
          Center(child: ElevatedButton(onPressed: (){
           createButtonClicked();
          }, child: const Text('create')))
        ],
      ),),
    );
  }
  
  void createButtonClicked() {
    final categoryName = catagoryController.text.trim();
   final categoryData = CatogoryReqModel(name: categoryName);
   CategoryService().categoryCreate(categoryData);
  }
}