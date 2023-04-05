import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/gig_provider/new_gig_create_provider.dart';
import 'package:smartico/application/vendor/gig_provider/show_all_gig_provider.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/gigs/gigs_add_scrn.dart';

class GigsScreen extends StatefulWidget {
  const GigsScreen({super.key});

  @override
  State<GigsScreen> createState() => _GigsScreenState();
}

File? image;
File? cameraImage;
File? galleryImage;

class _GigsScreenState extends State<GigsScreen> {
  @override
  void initState() {
   
     first();
  }

  List recomendedServiceImage = [
    'assets/splash/painter.jpeg',
    'assets/splash/plumbing.jpeg',
    'assets/works/driver 2.jpg',
    'assets/splash/tree cutting.jpeg',
    'assets/splash/tv repair.jpeg',
    'assets/works/driver.jpg',
    'assets/splash/electrician 2.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
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
                        onTap: () => pickImageFromCamera(),
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
                        onTap: () async {
                          await pickImageFromGallery();
                          
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
          
          },
          icon: const Icon(Icons.add),
          label: const Text('Add New Gigs')),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 121, 216, 206),
        // ignore: prefer_const_constructors
        title: Text(
          'Your Gigs',
          style: headText,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Driving',
                          style: mediumText,
                        ),
                        const Icon(Icons.edit),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      width: width,
                      height: width / 1.1,
                      color: Colors.red,
                      child: Image(
                        image: AssetImage(recomendedServiceImage[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$40',
                          style: normalText,
                        ),
                        const Text(
                          'We are providing good driving service in low service charge,and its excellent for all of you',
                          style: TextStyle(fontSize: 18),
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              itemCount: 7,
              separatorBuilder: (context, index) => const Divider(
                thickness: 3,
              ),
            ),
          ),
        ],
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
      setState(() => galleryImage = imageTemp);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GigsAddScreen(imagePath: galleryImage),
          ));
     
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
      setState(() => cameraImage = imageTemp);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GigsAddScreen(imagePath: cameraImage),
          ));
  
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  
  void first() async{
    await context.read<ShowAllGigsProvider>().callApiServiceGigs();
    await context.read<NewGIgCreateProvider>().getAllCategory(context);
    FlutterSecureStorage storage = FlutterSecureStorage();
    final vendorId = await storage.read(key: 'vendorId');
   
  }
}
