// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/profile/vendor_profile.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/vendor/model/profile/edit_profile_model.dart';

class VendorProfileEdit extends StatefulWidget {
  VendorProfileEdit(
      {super.key,
      required this.userName,
      required this.mobile,
      required this.gender,
      required this.skills,
      required this.googledrive,
      required this.linkedIn,
      required this.github,
      required this.about,
      required this.currentAddress,
      required this.country,
      required this.state,
      required this.city,
      required this.profilePic});
  String? userName;
  String? mobile;
  String? gender;
  String? skills;
  String? googledrive;
  String? linkedIn;
  String? github;
  String? about;
  String? currentAddress;
  String? country;
  String? state;
  String? city;
  String? profilePic;

  @override
  State<VendorProfileEdit> createState() => _VendorProfileEditState();
}

class _VendorProfileEditState extends State<VendorProfileEdit> {
  File? cameraImage;
  String? gigImage;
  File? gigImageFile;
  dynamic file;
  File? galleryImage;
  int flag = 0;
  final cloudinary = CloudinaryPublic('dzeuipdky', 'ml_default', cache: false);

  @override
  void initState() {
    userNameController.text = widget.userName.toString();
    mobileController.text = widget.mobile.toString();
    genderController.text = widget.gender.toString();
    skillsController.text = widget.skills.toString();
    googleDriveController.text = widget.googledrive.toString();
    linkedInController.text = widget.linkedIn.toString();
    gitHubController.text = widget.github.toString();
    currentAddressController.text = widget.currentAddress.toString();
    countryController.text = widget.country.toString();
    stateController.text = widget.state.toString();
    cityController.text = widget.city.toString();
    super.initState();
  }

  final userNameController = TextEditingController();

  final mobileController = TextEditingController();

  final upiIdController = TextEditingController();

  final genderController = TextEditingController();

  final skillsController = TextEditingController();

  final googleDriveController = TextEditingController();

  final linkedInController = TextEditingController();

  final gitHubController = TextEditingController();

  final currentAddressController = TextEditingController();

  final countryController = TextEditingController();

  final stateController = TextEditingController();

  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title:
            Text("Edit Profile", style: headText.copyWith(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 6,
              width: double.infinity,
              child: Center(
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    bottomSheet(context, width);
                  },
                  child: gigImageFile != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(gigImageFile!),
                          radius: 60,
                        )
                      : widget.profilePic != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                widget.profilePic!,
                              ),
                              radius: 60,
                            )
                          : const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/splash/unknown.jpg'),
                              radius: 60,
                            ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  MyTextFormField(
                    controller: userNameController,
                    labelText: 'Username',
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: mobileController,
                    labelText: 'Phone',
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: genderController,
                    labelText: "Gender",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: skillsController,
                    labelText: "Skills",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: googleDriveController,
                    labelText: "Google Drive",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: gitHubController,
                    labelText: "GIt Hub",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: linkedInController,
                    labelText: "LinkedIn",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: currentAddressController,
                    labelText: "Address",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: countryController,
                    labelText: "Coutry",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: stateController,
                    labelText: "State",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: cityController,
                    labelText: "City",
                  ),
                  kHeight10,
                  ElevatedButton(
                    onPressed: () {
                      updateButtonClicked();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(width / 1.1, 45),
                        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      'UPDATE',
                      style: normalText.copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
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

  Future<void> updateButtonClicked() async {
    dynamic url;
    if (gigImageFile != null) {
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(gigImageFile!.path,
              resourceType: CloudinaryResourceType.Image));
      url = response.secureUrl;
    }

    EditVendorProfileModel editedData = EditVendorProfileModel(
        city: cityController.text,
        country: countryController.text,
        currentAddress: currentAddressController.text,
        gender: genderController.text,
        github: gitHubController.text,
        googleDrive: googleDriveController.text,
        linkedIn: linkedInController.text,
        mobile: mobileController.text,
        profilePhoto: url ?? widget.profilePic,
        skill: skillsController.text,
        state: stateController.text,
        upiId: upiIdController.text,
        userName: userNameController.text);
    await Provider.of<VendorProfileProvider>(context, listen: false)
        .editVendorProfile(editedData);
    await Provider.of<VendorProfileProvider>(context, listen: false)
        .getVendorDetails();
    Navigator.pop(context);
  }
}
