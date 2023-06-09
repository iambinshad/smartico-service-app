import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/admin/controller/all_vendors/vendor_managing_service.dart';
import 'package:smartico/application/admin/fetch_all_vendors/fetch_all_vendors_provider.dart';

class AllVendorForAdmin extends StatelessWidget {
  const AllVendorForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Vendors"),
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
      ),
      body: Consumer<AllVendorListForAdmin>(
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () {},
            title: Text(value.allVendors![index]!.fullName!),
            trailing: ElevatedButton(
              onPressed: () {
                if (value.allVendors![index]!.status! == "Not Approved") {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Approve Vendor'),
                        content: Text(
                            "Are You Sure You Want To Approve ${value.allVendors![index]!.fullName!}"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          ElevatedButton(
                              onPressed: () {
                                value.approveVendor(
                                    value.allVendors![index]!.id!);
                                    
                                Navigator.pop(context);
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.green)),
                              child: const Text(
                                "Approve",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Block Vendor'),
                        content: Text(
                            "Are You Sure You Want To Block ${value.allVendors![index]!.fullName!}"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                VendorManagementService().blockVendor(
                                    context, value.allVendors![index]!.id!);
                              },
                              child: const Text("Block")),
                        ],
                      );
                    },
                  );
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      value.allVendors![index]!.status! == 'Not Approved'
                          ? Colors.red
                          : Colors.green)),
              child: Text(
                value.allVendors![index]!.status!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            leading: value.allVendors![index]!.profilePhoto != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      value.allVendors![index]!.profilePhoto!,
                    ),
                  )
                : const CircleAvatar(),
          ),
          itemCount: value.allVendors!.length,
        ),
      ),
    );
  }
}
