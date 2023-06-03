import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/gig_provider/new_gig_create_provider.dart';
import 'package:smartico/application/vendor/gig_provider/show_all_gig_provider.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/vendor/model/category/get_all_category.dart';
import 'package:smartico/vendor/model/new_gig/new_gig_create_model.dart';
import 'package:smartico/vendor/view/bottom_nav/vendor_bottom_nav.dart';
import '../../../../application/vendor/vendor_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

// ignore: must_be_immutable
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          'Add Gig',
          style: headText,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Card(
              elevation: 5.0,
              child: SizedBox(
                height: width / 1.5,
                width: width,
                child: Image.file(
                  widget.imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  TextFieldName(value: 'Title'),
                  MyTextFormField(
                    controller: titleController,
                    
                  ),
                  TextFieldName(value: 'Overview'),
                  MyTextFormField(
                    controller: overViewController,
                  ),
                  TextFieldName(value: 'Description'),
                  MyTextFormField(
                    controller: descriptionController,
                  ),
                  TextFieldName(value: 'Price'),
                  MyTextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                  ),
                  TextFieldName(value: 'Type'),
                  Consumer<NewGIgCreateProvider>(
                    builder: (context, values, child) => Row(
                      children: [
                        Checkbox(
                          value: values.addserviceCheckBoxValue,
                          onChanged: (value) {
                            values.setServiceCheck();
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        const Text('Service'),
                        Checkbox(
                          value: values.addproductCheckBoxValue,
                          onChanged: (value) {
                            values.setProductCheck();
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        const Text('Product')
                      ],
                    ),
                  ),
                  !Provider.of<NewGIgCreateProvider>(context, listen: false)
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
                      items: value2.categories
                          .map((category) => DropdownMenuItem<CategoryResModel>(
                                value: category,
                                child: Text(category!.name),
                              ))
                          .toList(),
                      onChanged: (CategoryResModel? category) {
                        value2.setCategory(category, category!.id,context);
                      },
                      validator: (value) {
                        if (value2.selectedCategory == null) {
                          return 'Category is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(Icons.category),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.black)),
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: context.watch<NewGIgCreateProvider>().isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    saveButtonPressed();
                                  }
                                },
                                style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    minimumSize: MaterialStatePropertyAll(
                                        Size(width / 1.1, 50)),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            Color.fromARGB(
                                                255, 123, 230, 219))),
                                child: Text(
                                  'Save',
                                  style: normalText,
                                )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: SizedBox(
            height: 50.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  void saveButtonPressed() async {
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
    if (context.read<NewGIgCreateProvider>().addserviceCheckBoxValue) {
      type = 'Service';
      
    } else if (context.read<NewGIgCreateProvider>().addproductCheckBoxValue) {
      type = 'Product';
    }
    var gigCreateDatas = NewGigCreateModel(
        title: title,
        overview: overView,
        image: url,
        type: type,
        description: description,
        price: price,
        category: context.read<NewGIgCreateProvider>().selectedCategoryId,
        vendorId: vendorId.toString());
      await context.read<NewGIgCreateProvider>().createNewGig(gigCreateDatas, context);
      context.read<NewGIgCreateProvider>().getAllCategory(context);
      await Provider.of<ShowAllGigsProvider>(context,listen: false).callApiServiceGigs(context);
      Navigator.pop(context);
  }
}
