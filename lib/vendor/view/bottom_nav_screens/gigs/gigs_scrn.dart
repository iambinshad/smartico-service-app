import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/vendor/all_booking/all_bookings.dart';
import 'package:smartico/application/vendor/chat/chat_connection_provider.dart';
import 'package:smartico/application/vendor/gig_provider/new_gig_create_provider.dart';
import 'package:smartico/application/vendor/gig_provider/show_all_gig_provider.dart';
import 'package:smartico/application/vendor/profile/vendor_profile.dart';
import 'package:smartico/core/theme/access_token/token.dart';
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
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //    Provider.of<ShowAllGigsProvider>(context, listen: false).loadingState(true);
  // }
  File? addGalleryImage;
  File? addCameraImage;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      fetchDatas();
      Provider.of<VendorConnectionService>(context, listen: false)
          .vendorConnection();
      context.read<NewGIgCreateProvider>().getAllCategory(context);
      Provider.of<VendorProfileProvider>(context, listen: false)
          .getVendorDetails();
      Provider.of<AllBookingProvider>(context, listen: false)
          .fetchAllBookings(context);
          final vendor = await getVendorAccesToken();
          log(vendor.toString(),name: "vendoreeeeeeeeeeeee");
    });

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: IconButton(
        style:
            const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 16, 81, 135))),
        onPressed: () {
          bottomSheet(context, width);
        },
        icon: const Icon(
          Icons.add_box_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
      // appBar: AppBar(
      //   elevation: 5.0,
      //   backgroundColor: Color.fromARGB(255, 16, 81, 135),
      //   title: Text(
      //     'Gigs',
      //     style: GoogleFonts.monoton(fontSize: 25),
      //   ),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          Expanded(
            child: Consumer2<ShowAllGigsProvider, CommonProvider>(
              builder: (context, value, value2, child) {
                return context.watch<ShowAllGigsProvider>().isLoading
                    ? LoadingAnimationWidget.fourRotatingDots(
                        color: const Color.fromARGB(255, 113, 113, 113),
                        size: 25.0)
                    : value.vendorGigs!.isEmpty
                        ?  Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                        color: const Color.fromARGB(255, 113, 113, 113),
                        size: 10.0),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return value2.shimmerLoading
                                  ? gigScrnShimmer(width)
                                  : GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GigDescripttion(
                                              index: index,
                                              title: value
                                                  .vendorGigs![index].title,
                                            ),
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
                                                              color:
                                                                  Colors.black,
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
                                                            fontSize: 15,
                                                          ),
                                                        ))
                                                  ],
                                                  onSelected: (popvalue) {
                                                    if (popvalue == 1) {
                                                      // context.read<NewGIgCreateProvider>().getAllCategory(context);
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
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Text(
                                                                      'Cancel')),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await value.deleteGig(
                                                                        value2
                                                                            .vendorGigs![index]
                                                                            .id,
                                                                        context);
                                                                    await Provider.of<ShowAllGigsProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .callApiServiceGigs(
                                                                            context);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  )),
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
                                                      style: const TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    kHeight10,
                                                    Text(
                                                      "\u{20B9}${value.vendorGigs![index].price}",
                                                      style:
                                                          GoogleFonts.notoSans(
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  value.vendorGigs![index].category.name,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            },
                            itemCount: value.vendorGigs!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox());
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
    Provider.of<ShowAllGigsProvider>(context, listen: false).loadingState(true);
    context.read<ShowAllGigsProvider>().callApiServiceGigs(context);
    if (mounted) {
      Provider.of<ShowAllGigsProvider>(context, listen: false)
          .loadingState(false);
    }
  }
}

File? image;
