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
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    fullNameController.clear();
    stateController.clear();
    districtController.clear();
    localityController.clear();
    nearByController.clear();
    locationController.clear();
    phoneController.clear();
  }

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
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
          builder: (context, snapshot) => Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                      child: SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: Image(
                      image: AssetImage("assets/splash/bgImage.jpeg"),
                      fit: BoxFit.fill,
                    ),
                  )),
                  InkWell(
                    onTap: () {
                      bottomSheet(context, width);
                    },
                    child: gigImageFile != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(gigImageFile!),
                            radius: 80,
                          )
                        : snapshot.data?.profilePhoto != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  snapshot.data!.profilePhoto!,
                                ),
                                radius: 80,
                              )
                            : const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/splash/unknown.jpg'),
                                radius: 80,
                              ),
                  ),
                ],
              ),
              kHeight10,
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SizedBox(
                    child: Column(
                      children: [
                        MyTextFormField(
                          hintText: 'Full Name',
                          controller: fullNameController,
                        ),
                        kHeight10,
                        MyTextFormField(
                          hintText: 'Phone',
                          controller: phoneController,
                        ),
                        kHeight15,
                        locationController.text.isNotEmpty
                            ? MyTextFormField(
                                controller: locationController,
                                keyboardType: TextInputType.none,
                                labelText: 'Click To Add Location',
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    permission =
                                        await Geolocator.requestPermission();
                                    if (permission !=
                                            LocationPermission.denied ||
                                        permission !=
                                            LocationPermission.deniedForever) {
                                      if(mounted){showModel(context);}
                                    }
                                  },
                                  icon: const Icon(Icons.place_outlined),
                                  color: Colors.blue,
                                ),
                              )
                            : SizedBox(
                                width: width / 1.12,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    permission =
                                        await Geolocator.requestPermission();
                                    if (permission !=
                                            LocationPermission.denied ||
                                        permission !=
                                            LocationPermission.deniedForever) {
                                    if(mounted){  showModel(context);}
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 16, 81, 135),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    'Add Location',
                                    style:
                                        headText.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                        kHeight10,

                        kHeight15,
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
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              kHeight30,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Having an issue with this application?'),
                  Text(
                    ' Tell us more',
                    style: TextStyle(color: Color.fromARGB(255, 121, 216, 206)),
                  )
                ],
              )
            ],
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
            child: SizedBox(
              child: OpenStreetMapSearchAndPick(
                  onGetCurrentLocationPressed: fetchCurrentLocation,
                  center: LatLong(latitude, longitude),
                  buttonColor: Colors.blue,
                  buttonText: 'Set Current Location',
                  onPicked: (pickedData) {
                    Navigator.pop(context);

                    setState(() {
                      locationController.text = pickedData.address;

                      locationAddress = pickedData.address;
                    
                      latitude = pickedData.latLong.latitude;
                      longitude = pickedData.latLong.longitude;
                      List<String> splited = locationAddress.split(',');
                      
                      stateController.text = splited[splited.length - 1];
                      districtController.text = splited[splited.length - 3];
                      localityController.text = splited[splited.length - 6];
                      nearByController.text = splited[0] + splited[1];
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
      if (permission == LocationPermission.denied &&
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }
      LatLng position = await getCurrentLocation();

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

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if(mounted){showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.info(
          message: 'Location Service Not Enabled',
        ),
      );}
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

   if(mounted){ await Provider.of<UserProfileProvider>(context, listen: false)
        .editUserProfile(editedData);
    }
    if(mounted){
      await Provider.of<UserProfileProvider>(context, listen: false)
        .getUserDetails();
    }
    if(mounted){Navigator.pop(context);}
  }
}
