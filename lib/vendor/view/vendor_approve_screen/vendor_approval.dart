import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartico/vendor/model/complete_sign_up/complete_sign_up.dart';
import '../../../core/widgets.dart';

class VendorApproval extends StatefulWidget {
  const VendorApproval({super.key});

  @override
  State<VendorApproval> createState() => _VendorApprovalState();
}

class _VendorApprovalState extends State<VendorApproval> {
  final address = TextEditingController();
  final about = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final pincode = TextEditingController();
  final skill = TextEditingController();
  final googleDrive = TextEditingController();
  final linkedIn = TextEditingController();
  final gitHub = TextEditingController();

  String profile = 'assets/splash/unknown.jpg';

  File? cameraImage;
  File? galleryImage;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 123, 230, 219),
          ),
          body: SingleChildScrollView(
            child: Card(
              child: Column(
                children: [
                  kHeight10,
                  Center(
                    child: CircleAvatar(
                      radius: 63,
                      backgroundColor: const Color.fromARGB(255, 123, 230, 219),
                      child: GestureDetector(
                          onTap: () {
                            showModelBottomSheet(context, width);
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(profile),
                          )),
                    ),
                  ),
                  const Text(
                    'Nicolas Adams',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text('binshadp999@gmail.com',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 99, 99, 99))),
                  kHeight10,
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                      children: [
                        MyTextFormField(
                            controller: address,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Address is Required';
                              }
                              return null;
                            },
                            hintText: 'Enter Address',
                            labelText: 'Address'),
                        kHeight20,
                        MyTextFormField(
                            controller: about,
                            hintText: 'About',
                            labelText: 'About'),
                        kHeight20,
                        MyTextFormField(
                            controller: country,
                            hintText: 'Enter Country',
                            labelText: 'Country'),
                        kHeight20,
                        MyTextFormField(
                            controller: state,
                            hintText: 'State',
                            labelText: 'State'),
                        kHeight20,
                        MyTextFormField(
                            controller: city,
                            hintText: 'City',
                            labelText: 'City'),
                        kHeight20,
                        MyTextFormField(
                            keyboardType: TextInputType.number,
                            controller: pincode,
                            hintText: 'Pincode',
                            labelText: 'Pincode'),
                        kHeight20,
                        MyTextFormField(
                            controller: skill,
                            hintText: 'Enter Your Skills',
                            labelText: 'Skill'),
                        kHeight20,
                        MyTextFormField(
                            controller: googleDrive,
                            hintText: 'Google Drive',
                            labelText: 'Google Drive'),
                        kHeight20,
                        MyTextFormField(
                            controller: linkedIn,
                            hintText: 'LinkedIn',
                            labelText: 'LinkedIN'),
                        kHeight20,
                        MyTextFormField(
                            controller: gitHub,
                            hintText: 'GitHub',
                            labelText: 'GitHub'),
                        kHeight20,
                      ],
                    ),
                  ),
                  // ElevatedButton(
                  //   style: ButtonStyle(shape: MaterialStatePropertyAll(BorderSide()),padding:MaterialStatePropertyAll(EdgeInsets.only(right: width/3,left: width/3))),
                  //   onPressed: (){}, child:Text('SUBMIT',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                  GestureDetector(
                    onTap: () {
                      submitButtonClicked();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 230, 219),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: width / 1.16,
                      child: const Center(
                          child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  kHeight10
                ],
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
        profile = galleryImage!.path.toString();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
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
        profile = cameraImage!.path.toString();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
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
                child: Column(
                  children: const [
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
                child: Column(
                  children: const [
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

  void submitButtonClicked() {
    final completeSignUpdatas = CompleteSignUpModel(
      skill: skill.text,
      googleDrive: googleDrive.text,
      linkedIn: linkedIn.text,
      github: gitHub.text,
      address: Address(pincode: pincode.text, country: country.text, currentAddress: address.text, city: city.text, state: state.text),
      about: about.text,
      profilePhoto: profile,
      
    );
  }
}
