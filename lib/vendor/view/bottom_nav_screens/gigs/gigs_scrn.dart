import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
          style:
              ButtonStyle(backgroundColor: MaterialStatePropertyAll(mainColor)),
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
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          label: Text(
            'Add New Gigs',
            style: GoogleFonts.sigmarOne(color: Colors.black),
          )),
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: const Color.fromARGB(255, 121, 216, 206),
        // ignore: prefer_const_constructors
        title: Text(
          'Gigs',
          style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ShowAllGigsProvider>(
              builder: (context, value, child) => ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(right: 5, left: 5, bottom: 5),
                      child: Card(
                        elevation: 3.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        value.vendorGigs![index].image),
                                    fit: BoxFit.fill,
                                  ),
                                  color: Colors.red,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              width: width,
                              height: width / 1.75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  PopupMenuButton(
                                    icon: const Icon(
                                      Icons.more_vert_outlined,
                                      color: Colors.white,
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 1,
                                        child: const Text('Edit',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'poppins',
                                                fontSize: 15)),
                                        onTap: () {},
                                      ),
                                      const PopupMenuItem(
                                        enabled: true,
                                          value: 2,
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'poppins',
                                                fontSize: 15),
                                                
                                          ))
                                          
                                    ],
                                    onSelected: (value) {
                                      if (value == 2) {}
                                    },
                                    
                                    elevation: 2,
                                  ),
                                 
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        value.vendorGigs![index].title,
                                        style:
                                            GoogleFonts.sigmarOne(fontSize: 20),
                                      ),
                                      Text(
                                        "\$${value.vendorGigs![index].price}",
                                        style: GoogleFonts.notoSans(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    value.vendorGigs![index].type,
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 18,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: value.vendorGigs!.length,
                  separatorBuilder: (context, index) => const SizedBox()),
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

  void first() async {
    await context.read<ShowAllGigsProvider>().callApiServiceGigs();
    await context.read<NewGIgCreateProvider>().getAllCategory(context);
  }
}
