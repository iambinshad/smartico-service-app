import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/profile/user_profile.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/model/profile_page/profile_edit_model.dart';

class EditUserProfile extends StatefulWidget {
  EditUserProfile({super.key, required this.userName, required this.phone,required this.profilePic });

  String? userName;
  int? phone;
  String? profilePic;

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  File? galleryImage;
    final cloudinary = CloudinaryPublic('dzeuipdky', 'ml_default', cache: false);

  File? cameraImage;
  String? gigImage;
  File? gigImageFile;
  dynamic file;
  int flag = 0;
  @override
  void initState() {
      fullNameController.text = widget.userName!;
      phoneController.text = widget.phone.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: normalText,
        ),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, value, child) => 
         FutureBuilder(
          future: value.userDetails,
          builder: (context, snapshot) => 
            SizedBox(
            height: 400,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          bottomSheet(context, width);
                        },
                        child: gigImageFile != null
                            ? CircleAvatar(
                                backgroundImage: FileImage(gigImageFile!),
                                radius: 60,
                              )
                            :  snapshot.data?.profilePhoto !=null?CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data!.profilePhoto!,),
                              radius: 60,
                            ):const CircleAvatar(
                              backgroundImage:
                              
                                  AssetImage('assets/splash/unknown.jpg'),
                              radius: 60,
                            ),
                      ),
                      kHeight10,
                      MyTextFormField(
                        hintText: 'Full Name',
                        controller: fullNameController,
                      ),
                      kHeight10,
                      MyTextFormField(
                        hintText: 'Phone',
                        controller: phoneController,
                      ),
                      kHeight10,
                      SizedBox(
                        width: width / 1.12,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            updateButtonClicked();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'UPDATE',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                 ),
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
    dynamic url ;
      if(gigImageFile!=null){ CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(gigImageFile!.path,
              resourceType: CloudinaryResourceType.Image));
       url = response.secureUrl;}
    UserProfileEditModel editedData = UserProfileEditModel(userName: fullNameController.text.trim(),phone: phoneController.text.trim(),profilePhoto:url??widget.profilePic);
    if(context.mounted){}
    await Provider.of<UserProfileProvider>(context,listen: false).editUserProfile(editedData);
    Navigator.pop(context);

  }
}
