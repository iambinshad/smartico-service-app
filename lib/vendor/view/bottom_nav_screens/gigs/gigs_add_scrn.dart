import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/gig_provider/new_gig_create_provider.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/vendor/model/category/get_all_category.dart';
import 'package:smartico/vendor/model/new_gig/new_gig_create_model.dart';
import '../../../../application/vendor/vendor_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class GigsAddScreen extends StatefulWidget {
  GigsAddScreen({super.key, required this.imagePath});
  File? imagePath;

  @override
  State<GigsAddScreen> createState() => _GigsAddScreenState();
}

class _GigsAddScreenState extends State<GigsAddScreen> {
  final titleController = TextEditingController();
  final serviceTypeController = TextEditingController();
  final overViewController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final cloudinary = CloudinaryPublic('dzeuipdky', 'ml_default', cache: false);
  bool serviceCheckBoxValue = false;
  bool productCheckBoxValue = false;

  @override
  Widget build(BuildContext context) {
    final newGigProv =
        Provider.of<NewGIgCreateProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Add Gig',
          style: headText,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: width / 1.5,
                width: width,
                child: Image.file(
                  widget.imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFieldName(value: 'Title'),
                    MyTextFormField(
                        hintText: 'Title', controller: titleController),
                    TextFieldName(value: 'Overview'),
                    MyTextFormField(
                      controller: overViewController,
                    ),
                    TextFieldName(value: 'Description'),
                    MyTextFormField(controller: descriptionController),
                    TextFieldName(value: 'Price'),
                    MyTextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                    ),
                    TextFieldName(value: 'Type'),
                    Row(
                      children: [
                        Checkbox(
                          value: serviceCheckBoxValue,
                          onChanged: (value) {
                            setState(() {
                              serviceCheckBoxValue = !serviceCheckBoxValue;
                              productCheckBoxValue = !serviceCheckBoxValue;
                            });
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        const Text('Service'),
                        Checkbox(
                          value: productCheckBoxValue,
                          onChanged: (value) {
                            setState(() {
                              productCheckBoxValue = !productCheckBoxValue;
                              serviceCheckBoxValue = !productCheckBoxValue;
                            });
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        const Text('Product')
                      ],
                    ),
                    !Provider.of<NewGIgCreateProvider>(context,listen: false)
                            .vendorSideTypeValidation
                        ? Consumer(
                            builder: (context, value, child) {
                              return const Text(
                                'Type is required',
                                style: TextStyle(color: Colors.red),
                              );
                            },
                          )
                        : const SizedBox(),
                    TextFieldName(value: 'Category'),
                    Consumer2<VendorProvider, NewGIgCreateProvider>(
                        builder: (context, value, value2, child) {
                      return DropdownButtonFormField<CategoryResModel>(
                        value: value2.selectedCategory,
                        hint: const Text('Select Category'),
                        items: value2.categories
                            .map((category) =>
                                DropdownMenuItem<CategoryResModel>(
                                  value: category,
                                  child: Text(category!.name),
                                ))
                            .toList(),
                        onChanged: (CategoryResModel? category) {
                          setState(() {
                            value2.selectedCategory = category;
                            value2.selectedCategoryId = category!.id;
                          });
                        },
                        validator: (value) {
                          if (value2.selectedCategory == null) {
                            return 'Category is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 123, 230, 219))),
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 111, 111, 111),
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              saveButtonPressed(newGigProv);
                            }
                          },
                          style: ButtonStyle(
                              padding: MaterialStatePropertyAll(EdgeInsets.only(
                                  right: width / 2.9,
                                  left: width / 2.9,
                                  bottom: 12,
                                  top: 12)),
                              backgroundColor: const MaterialStatePropertyAll(
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
      ),
    );
  }

  void saveButtonPressed(newGigProv) async {
    var title = titleController.text.trim();
    var overView = overViewController.text.trim();
    var description = descriptionController.text.trim();
    var price = priceController.text.trim();
    FlutterSecureStorage storage = const FlutterSecureStorage();
    var vendorId = await storage.read(key: 'vendorId');

    

    if (!_formKey.currentState!.validate()) {
      return;
    }

    CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(widget.imagePath!.path,
            resourceType: CloudinaryResourceType.Image));
    final url = response.secureUrl;
    dynamic type;
    if(serviceCheckBoxValue){
      type = 'Service';
    }else if(productCheckBoxValue){
      type = 'Product';
    }

    var gigCreateDatas = NewGigCreateModel(
        title: title,
        overview: overView,
        image: url,
        type: type,
        description: description,
        price: price,
        category: newGigProv.selectedCategoryId,
        vendorId: vendorId.toString());
      newGigProv.createNewGig(gigCreateDatas, context);
       newGigProv.getAllCategory(context);
     Navigator.pop(context);
    
     
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
