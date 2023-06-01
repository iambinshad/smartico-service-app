import 'dart:developer';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/complete_signup/complete_signup_provider.dart';
import 'package:smartico/vendor/view/vendor_approve_screen/vendor_approve_scrn2.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../core/widgets.dart';

class VendorApprovalFirstScrn extends StatefulWidget {
  const VendorApprovalFirstScrn({super.key});

  @override
  State<VendorApprovalFirstScrn> createState() =>
      _VendorApprovalFirstScrnState();
}

File? profile;
String unknown = 'assets/splash/unknown.jpg';

class _VendorApprovalFirstScrnState extends State<VendorApprovalFirstScrn> {
  bool res = false;
  final _formKey = GlobalKey<FormState>();
  final cloudinary = CloudinaryPublic('dzeuipdky', 'ml_default', cache: false);

  File? cameraImage;
  File? galleryImage;

  @override
  Widget build(BuildContext context) {
    final prov = context.read<CompleteSignUpProvider>();
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Profile Information'),
            backgroundColor: const Color.fromARGB(255, 123, 230, 219),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kHeight40,
                     
                      Center(
                        child: CircleAvatar(
                          radius: 63,
                          backgroundColor: const Color.fromARGB(255, 123, 230, 219),
                          child: GestureDetector(
                              onTap: () {
                                showModelBottomSheet(context, width);
                              },
                              child: profile != null
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundImage: FileImage(profile!),
                                    )
                                  : CircleAvatar(
                                      radius: 60,
                                      backgroundImage: AssetImage(
                                        unknown,
                                      ),
                                    )),
                        ),
                      ),
                      Text(
                        prov.fullName.text,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(prov.email.text,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 99, 99, 99))),
                      kHeight10,
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Column(
                          children: [
                            MyTextFormField(
                                controller: prov.address,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Address is Required';
                                  }
                                  return null;
                                },
                                
                                labelText: 'Address'),
                                kHeight20,
                                MyTextFormField(
                                  keyboardType: TextInputType.number,
                                controller: prov.pincode,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Pincode is Required';
                                  }
                                  return null;
                                },
                                
                                labelText: 'Pincode'),

                            kHeight20,
                            MyTextFormField(
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'About is required';
                                  }
                                  return null;
                                },
                                controller: prov.about,
                                
                                labelText: 'About'),
                            kHeight20,
                            cscPicker(),
                            kHeight20,
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            res = cscPickerValidate();
                          }
                          if (res == false) {
                            showTopSnackBar(
                              Overlay.of(context),
                              const CustomSnackBar.info(
                                message: 'Complete filling!',
                              ),
                            );
                          }
                          if (res) {
                            nextButtonClicked(profile);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 123, 230, 219),
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          width: width / 1.19,
                          child: const Center(
                              child: Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white),
                          )),
                        ),
                      ),
                      kHeight10
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(
        image.path,
      );
      setState(() {
        galleryImage = imageTemp;
        profile = galleryImage;
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
      setState(() {
        cameraImage = imageTemp;
        profile = cameraImage;
      });
    } on PlatformException catch (e) {
      log(e.message.toString());
    }
  }

  Future<dynamic> showModelBottomSheet(BuildContext context, double width) {
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
                  pickImageFromCamera();
                  Navigator.pop(context);
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
                onTap: () {
                  pickImageFromGallery();
                  Navigator.pop(context);
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

  bool cscPickerValidate() {
    final prov = context.read<CompleteSignUpProvider>();
    if (prov.countryValue != null &&
        prov.stateValue != null &&
        prov.cityValue != null &&
        profile != null) {
      return true;
    }
    return false;
  }

  void nextButtonClicked(File? profile) async {
    Provider.of<CompleteSignUpProvider>(context, listen: false).profileImage =
        profile!.path;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VendorApprovalSecondScrn(imagePath: profile,),
        ));
  }
}
