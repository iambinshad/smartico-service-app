import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/gig_provider/new_gig_create_provider.dart';
import 'package:smartico/application/vendor/gig_provider/show_all_gig_provider.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/vendor/model/category/get_all_category.dart';
import 'package:smartico/vendor/model/new_gig/edit_gig_model.dart';
import '../../../../application/vendor/vendor_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

// ignore: must_be_immutable
class GigEditScreen extends StatefulWidget {
  GigEditScreen(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.overView,
      required this.description,
      required this.price,
      required this.type,
      required this.gigId});
  String imagePath;
  String title;
  String description;
  String overView;
  int price;
  String type;
  String gigId;

  @override
  State<GigEditScreen> createState() => _GigEditScreenState();
}

class _GigEditScreenState extends State<GigEditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController serviceTypeController = TextEditingController();
  TextEditingController overViewController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final cloudinary = CloudinaryPublic('dzeuipdky', 'ml_default', cache: false);
  File? galleryImage;
  File? cameraImage;
  String? gigImage;
  File? gigImageFile;

  int flag = 0;

  @override
  void initState() {
    gigImage = widget.imagePath;
    titleController = TextEditingController(text: widget.title);
    overViewController = TextEditingController(text: widget.overView);
    descriptionController = TextEditingController(text: widget.description);
    priceController = TextEditingController(text: widget.price.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewGIgCreateProvider>(context, listen: false)
          .typeCheck(widget.type);
      context.read<NewGIgCreateProvider>().getAllCategory(context);
    });
    final newGigProv =
        Provider.of<NewGIgCreateProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
        title: Text(
          'Edit Gig',
          style: headText,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            flag != 0
                ? Consumer<NewGIgCreateProvider>(
                    builder: (context, value, child) => Container(
                      height: width / 1.4,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(gigImageFile!),
                              fit: BoxFit.fill)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                bottomSheet(context, width);
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 30,
                                color: Color.fromARGB(255, 16, 81, 135),
                              ))
                        ],
                      ),
                    ),
                  )
                : Consumer<NewGIgCreateProvider>(
                    builder: (context, value, child) => Container(
                      height: width / 1.5,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(gigImage ?? ""),
                              fit: BoxFit.fill)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                bottomSheet(context, width);
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 30,
                                color: Color.fromARGB(255, 16, 81, 135),
                              ))
                        ],
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFieldName(
                    value: 'Title',
                  ),
                  MyTextFormField(
                    hintText: 'Title',
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
                          value: values.editserviceCheckBoxValue,
                          onChanged: (value) {
                            values.setEditServiceCheck();
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        const Text('Service'),
                        Checkbox(
                          value: values.editproductCheckBoxValue,
                          onChanged: (value) {
                            values.setEditProductCheck();
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
                      hint: const Text('Select Category'),
                      items: value2.categories
                          .map((category) => DropdownMenuItem<CategoryResModel>(
                                value: category,
                                child: Text(category!.name),
                              ))
                          .toList(),
                     onChanged: (CategoryResModel? category) {                      
                  value2.setCategory(category, category!.id,context);
                      },
                      decoration: InputDecoration(
                        isDense: true,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            updateButtonPressed(newGigProv, widget.gigId);
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.only(
                              right: width / 2.9,
                              left: width / 2.9,
                              bottom: 12,
                              top: 12)),
                          backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 16, 81, 135)),
                        ),
                        child: Text(
                          'Update',
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

  Future<dynamic> bottomSheet(BuildContext context, double width) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 95,
        width: width / 1.1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  pickImageFromCamera();
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.blue,
                      size: 40,
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await pickImageFromGallery();
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.photo,
                      color: Colors.blue,
                      size: 40,
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateButtonPressed(newGigProv, gigId) async {
    var title = titleController.text.trim();
    var overView = overViewController.text.trim();
    var description = descriptionController.text.trim();
    var price = priceController.text.trim();
    dynamic editImagePath;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (flag == 0) {
      editImagePath = gigImage;
    } else {
      editImagePath = gigImageFile!.path;
    }
    dynamic url;
    if (flag != 0) {
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(editImagePath,
              resourceType: CloudinaryResourceType.Image));
      url = response.secureUrl;
    }

    dynamic type;
    // ignore: use_build_context_synchronously
    if (Provider.of<NewGIgCreateProvider>(context, listen: false)
        .editserviceCheckBoxValue) {
      type = 'Service';
      // ignore: use_build_context_synchronously
    } else if (Provider.of<NewGIgCreateProvider>(context, listen: false)
        .editproductCheckBoxValue) {
      type = 'Product';
    }

    var gigEditDatas = EditGigModel(
        title: title,
        overview: overView,
        // ignore: use_build_context_synchronously
        image: url ?? gigImage,
        type: type,
        description: description,
        price: price,
        // ignore: use_build_context_synchronously
        category: context.read<NewGIgCreateProvider>().selectedCategoryId,
        gigId: gigId);
    if (mounted) {
      await Provider.of<NewGIgCreateProvider>(context, listen: false)
          .editGig(gigEditDatas, context);
    }
    
     if(mounted){ context.read<NewGIgCreateProvider>().getAllCategory(context);}
    

    if (mounted) {
      await context.read<ShowAllGigsProvider>().callApiServiceGigs(context);
    }
   if(mounted){ Navigator.pop(context);}
  }

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(
        image.path,
      );
      // if (mounted) {
      //   Provider.of<CommonProvider>(context,listen: false)
      //       .editStorageSetting(imageTemp);
      //   Provider.of<NewGIgCreateProvider>(context,listen: false).gigImageFile = Provider.of<CommonProvider>(context,listen: false).editGalleryImage;
      //    flag = 1;
      // }

      setState(() {
        galleryImage = imageTemp;
        gigImageFile = galleryImage;
        flag = 1;
      });
    } on PlatformException catch (e) {
      log(e.message.toString());
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(
        image.path,
      );
      // if (mounted) {
      //   Provider.of<CommonProvider>(context,listen: false)
      //       .editCameraSetting(imageTemp);
      // Provider.of<NewGIgCreateProvider>(context,listen: false).gigImageFile = Provider.of<CommonProvider>(context,listen: false).editCameraImage;
      //   flag = 1;
      // }

      setState(() {
        cameraImage = imageTemp;
        gigImageFile = cameraImage;
        flag = 1;
      });
    } on PlatformException catch (e) {
      log(e.message.toString());
    }
  }
}
