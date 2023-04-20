import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/admin/fetch_all_vendors/fetch_all_vendors_provider.dart';

class AllVendorForAdmin extends StatelessWidget {
  const AllVendorForAdmin({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      body: Consumer<AllVendorListForAdmin>(
        builder: (context, value, child) => 
         ListView.builder(itemBuilder: (context, index) =>ListTile(title:Text(value.allVendors![index]!.fullName!) ,)),),

    );
  }
}