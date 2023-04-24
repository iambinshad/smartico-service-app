import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/vendor/gig_provider/new_gig_create_provider.dart';
import 'package:smartico/application/vendor/gig_provider/show_all_gig_provider.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/gigs/gig_complete_description.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/gigs/gig_edit_scrn.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/gigs/gigs_add_scrn.dart';

class GigsScreen extends StatefulWidget {
  const GigsScreen({super.key});

  @override
  State<GigsScreen> createState() => _GigsScreenState();
}

class _GigsScreenState extends State<GigsScreen> {

  File? addGalleryImage;
  File? addCameraImage;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchDatas();
    });

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
          style:
              ButtonStyle(backgroundColor: MaterialStatePropertyAll(mainColor)),
          onPressed: () {
            bottomSheet(context, width);
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
        backgroundColor: mainColor,
        title: Text(
          'Gigs',
          style: GoogleFonts.monoton(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer2<ShowAllGigsProvider, CommonProvider>(
              builder: (context, value, value2, child) {
                return value.vendorGigs != null
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          return value2.shimmerLoading
                              ? gigScrnShimmer(width)
                              : GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GigDescripttion(index: index,title: value.vendorGigs![index].title,),
                                    )),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(value
                                              .vendorGigs![index].image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: width,
                                      height: width / 1.75,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          PopupMenuButton(
                                            icon: const Icon(
                                              Icons.more_vert_outlined,
                                              color: Colors.white,
                                            ),
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                value: 1,
                                                child: Text('Edit',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'poppins',
                                                        fontSize: 15)),
                                              ),
                                              const PopupMenuItem(
                                                  enabled: true,
                                                  value: 2,
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontFamily:
                                                            'poppins',
                                                        fontSize: 15,),
                                                  ))
                                            ],
                                            onSelected: (popvalue) {
                                              if (popvalue == 1) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => GigEditScreen(
                                                          imagePath: value
                                                              .vendorGigs![
                                                                  index]
                                                              .image,
                                                          title: value
                                                              .vendorGigs![
                                                                  index]
                                                              .title,
                                                          overView: value
                                                              .vendorGigs![
                                                                  index]
                                                              .overview,
                                                          description: value
                                                              .vendorGigs![
                                                                  index]
                                                              .description,
                                                          price: value
                                                              .vendorGigs![
                                                                  index]
                                                              .price,
                                                          type: value
                                                              .vendorGigs![
                                                                  index]
                                                              .type,
                                                          gigId: value
                                                              .vendorGigs![
                                                                  index]
                                                              .id),
                                                    ));
                                              } else if (popvalue == 2) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => Consumer2<
                                                      NewGIgCreateProvider,
                                                      ShowAllGigsProvider>(
                                                    builder: (context,
                                                            value,
                                                            value2,
                                                            child) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                          'Are You sure You want to delete this gig?'),
                                                      actions: [
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Cancel')),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              value.deleteGig(
                                                                  value2
                                                                      .vendorGigs![
                                                                          index]
                                                                      .id,
                                                                  context);
                                                            },
                                                            child:
                                                                const Text(
                                                                    'Yes',style: TextStyle(color: Colors.red),)),
                                                        
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            elevation: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                value.vendorGigs![index]
                                                    .title,
                                                style:
                                                    GoogleFonts.sigmarOne(
                                                        fontSize: 20),
                                              ),
                                              kHeight10,
                                              Text(
                                                "\$${value.vendorGigs![index].price}",
                                                style: GoogleFonts.notoSans(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            value.vendorGigs![index].type,
                                            style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontSize: 18,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                        },
                        itemCount: value.vendorGigs!.length,
                        separatorBuilder: (context, index) => const Center(child: Text('Gig is Empty!'),))
                    : gigScrnShimmer(width);
              },
            ),
          ),
        ],
      ),
    );
  }

  Shimmer gigScrnShimmer(width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6, left: 6),
            child: Container(
              color: Colors.white,
              width: width,
              height: width / 1.75,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 15,
                      width: 140,
                      color: Colors.white,
                    ),
                    Container(
                      height: 15,
                      width: 40,
                      color: Colors.white,
                    )
                  ],
                ),
                Container(
                  height: 15,
                  width: 140,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
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
                  Navigator.pop(context);
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
  }

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(
        image.path,
      );

      if (mounted) {
        context.read<CommonProvider>().addStorageSetting(imageTemp);
        context.read<NewGIgCreateProvider>().getAllCategory(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GigsAddScreen(
                  imagePath: context.read<CommonProvider>().addGalleryImage),
            ));
      }
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
      if (mounted) {
        context.read<CommonProvider>().addCameraSetting(imageTemp);
        context.read<NewGIgCreateProvider>().getAllCategory(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GigsAddScreen(
                  imagePath: context.read<CommonProvider>().addCameraImage),
            ));
      }
    } on PlatformException catch (e) {
      log(e.message.toString());
    }
  }

  void fetchDatas() async {
    Provider.of<CommonProvider>(context, listen: false).setShimmerLoading(true);
    context.read<ShowAllGigsProvider>().callApiServiceGigs(context);
    // await context.read<NewGIgCreateProvider>().getAllCategory(context);
    if (mounted) {
      Provider.of<CommonProvider>(context, listen: false)
          .setShimmerLoading(false);
    }
  }
}

File? image;
