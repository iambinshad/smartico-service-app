import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'package:smartico/core/constants.dart';
import 'package:smartico/vendor/model/new_gig/new_gig_create_model.dart';

import '../../../../application/vendor/vendor_provider.dart';
import '../../../controller/gig/new_gig.dart';

class GigsAddScreen extends StatelessWidget {
  GigsAddScreen({super.key, required this.imagePath});

  List categoryList = [
    'Cake',
    'Baking',
    'Electrician',
    'Painter',
    'Logo Maker',
  ];
  List serviceList = ['Service', "product"];

  final titleController = TextEditingController();
  final serviceTypeController = TextEditingController();
  final overViewController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  File? imagePath;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Add Gigs',
          style: headText,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: width / 1.5,
              width: width,
              child: Image.file(
                imagePath!,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFieldName(value: 'Title'),
                  TextFormField(
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is Required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 123, 230, 219))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Title here',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 111, 111, 111),
                      ),
                    ),
                  ),
                  TextFieldName(value: 'Overview'),
                  TextFormField(
                    controller: overViewController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Overview is required';
                      }
                      return null;
                    },
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 123, 230, 219))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Brief overview about gig',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 111, 111, 111),
                      ),
                    ),
                  ),
                  TextFieldName(value: 'Description'),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 123, 230, 219))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Brief description about gig',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 111, 111, 111),
                      ),
                    ),
                  ),
                  TextFieldName(value: 'Price'),
                  TextFormField(
                    controller: priceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Price is required';
                      }
                      return null;
                    },
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 123, 230, 219))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Gig value',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 111, 111, 111),
                      ),
                    ),
                  ),
                  TextFieldName(value: 'Type'),
                  Consumer<VendorProvider>(builder: (context, value, child) {
                    List<DropdownMenuItem<Object>> typeListObject = serviceList
                        .map((valueItem) => DropdownMenuItem(
                            value: valueItem, child: Text(valueItem)))
                        .toList();
                    return Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 5, left: 8, right: 8),
                          child: DropdownButton(
                            underline: const SizedBox(),
                            isExpanded: true,
                            hint: const Text('select type'),
                            items: typeListObject,
                            value: value.chooseType,
                            onChanged: (newValue) {
                              value.dropdownvalue(newValue, 2);
                              serviceTypeController.text = newValue.toString();
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                  TextFieldName(value: 'Category'),
                  Consumer<VendorProvider>(builder: (context, value, child) {
                    List<DropdownMenuItem<Object>> categoryListObject =
                        categoryList
                            .map((valueItem) => DropdownMenuItem(
                                value: valueItem, child: Text(valueItem)))
                            .toList();
                    return Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 5, left: 8, right: 8),
                          child: DropdownButton(
                            underline: const SizedBox(),
                            isExpanded: true,
                            hint: const Text('select category'),
                            items: categoryListObject,
                            value: value.chooseCatogory,
                            onChanged: (newValue) {
                              value.dropdownvalue(newValue, 3);
                              categoryController.text = newValue.toString();
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveButtonPressed();
                          }
                        },
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.only(
                                right: 161, left: 161, bottom: 12, top: 12)),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 123, 230, 219))),
                        child: Text(
                          'Save',
                          style: normalText,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveButtonPressed()async {
    var title = titleController.text.trim();
    var overView = overViewController.text.trim();
    var description = descriptionController.text.trim();
    var price = priceController.text.trim();
    FlutterSecureStorage storage = const FlutterSecureStorage();
    var vendorId = await storage.read(key: 'vendorId');
    log(price);
    log(overView);
    log(serviceTypeController.text.toString());
    log(categoryController.text.toString());

log(vendorId.toString());

    var gigCreateDatas = NewGigCreateModel(
        title: title,
        overview: overView,
        image: imagePath!.path,
        type: serviceTypeController.text.toString(),
        description: description,
        price: price,
        category: categoryController.text.toString(),
        vendorId: vendorId.toString());
        
        NewGigCreateApiService().newGigCreate(gigCreateDatas);
  }
}

class TextFieldName extends StatelessWidget {
  TextFieldName({super.key, required this.value});
  String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            value,
            style: normalText,
          ),
        ],
      ),
    );
  }
}
