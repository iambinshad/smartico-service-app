import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/profile/user_profile.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/model/profile_page/profile_edit_model.dart';

class EditUserProfile extends StatefulWidget {
  EditUserProfile(
      {super.key,
      required this.userName,
      required this.phone,
      required this.profilePic});

  String? userName;
  int? phone;

  String? profilePic;
  String locationAddress = 'Pick a Address';

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  TextEditingController districtController = TextEditingController();

  TextEditingController localityController = TextEditingController();
  TextEditingController nearByController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  File? galleryImage;
  final cloudinary = CloudinaryPublic('dzeuipdky', 'ml_default', cache: false);

  File? cameraImage;
  String? gigImage;
  File? gigImageFile;
  dynamic file;
  double latitude = 23, longitude = 86;

  LocationPermission? permission;

  String locationAddress = 'Pick a Address';
  String currentLocation = "Current Location";

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
          style: headText.copyWith(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
        centerTitle: true,
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, value, child) => FutureBuilder(
          future: value.userDetails,
          builder: (context, snapshot) => SizedBox(
            height: 700,
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
                            : snapshot.data?.profilePhoto != null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      snapshot.data!.profilePhoto!,
                                    ),
                                    radius: 60,
                                  )
                                : const CircleAvatar(
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
                      MyTextFormField(
                        hintText: 'State',
                        controller: stateController,
                      ),
                      kHeight10,
                      MyTextFormField(
                        hintText: 'District',
                        controller: districtController,
                      ),
                      kHeight10,
                      MyTextFormField(
                        hintText: 'Location',
                        controller: localityController,
                      ),
                      kHeight10,
                      MyTextFormField(
                        hintText: 'Nearby',
                        controller: nearByController,
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
                            backgroundColor:
                                const Color.fromARGB(255, 16, 81, 135),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'UPDATE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      kHeight10,
                      TextButton(
                          onPressed: () async {
                            permission = await Geolocator.requestPermission();
                           if(mounted){showModel(context);}
                          },
                          child: Text(locationAddress))
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

  showModel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 600,
          color: Colors.red,
          child: Center(
            child: Container(
              child: OpenStreetMapSearchAndPick(
                  onGetCurrentLocationPressed: fetchCurrentLocation,
                  center: LatLong(latitude, longitude),
                  buttonColor: Colors.blue,
                  buttonText: 'Set Current Location',
                  onPicked: (pickedData) {
                    Navigator.pop(context);

                    setState(() {

                      locationAddress = pickedData.address;
                      log(locationAddress);
                      latitude = pickedData.latLong.latitude;
                      longitude = pickedData.latLong.longitude;
                      List<String>splited = locationAddress.split(',');
                      log(splited.toString());
                      log(splited.length.toString());
                     stateController.text= splited[splited.length-1];
                     districtController.text= splited[splited.length-3];
                     localityController.text= splited[splited.length-6];
                     nearByController.text = splited[0]+splited[1];
                    });
                  }),
            ),
          ),
        );
      },
    );
  }

  Future<LatLng> fetchCurrentLocation() async {
    try {
      LatLng position = await getCurrentLocation();
      // log(position.latitude.toString());
      // log(position.longitude.toString());
      setState(() {
        currentLocation =
            'Latitude:${position.latitude}longitude${position.longitude}';
      });
      return position;
    } catch (e) {
      setState(() {
        currentLocation = 'Error : $e';
      });
    }
    return LatLng(23, 86);
  }

  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled;
    // LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error('Location permissions are denied.');
      }
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
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
    // final prov = Provider.of<UserProfileProvider>(context, listen: false);
    if (gigImageFile != null) {
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(gigImageFile!.path,
              resourceType: CloudinaryResourceType.Image));
      url = response.secureUrl;
    }
    String userLocation =
        "${stateController.text},${districtController.text},${localityController.text},${nearByController.text}";
    UserProfileEditModel editedData = UserProfileEditModel(
        userName: fullNameController.text.trim(),
        phone: phoneController.text.trim(),
        profilePhoto: url ?? widget.profilePic,
        location: userLocation);

    await Provider.of<UserProfileProvider>(context, listen: false)
        .editUserProfile(editedData);
    await Provider.of<UserProfileProvider>(context, listen: false)
        .getUserDetails();
    Navigator.pop(context);
  }
}
