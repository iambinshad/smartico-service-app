import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/all_vendor_prov.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/profile/user_profile.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';
import 'package:smartico/application/user/chat/chat_connection_provider.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/work_descrip.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/view_all_scrn.dart';
import 'package:smartico/vendor/view/authentication/vendor_sign_in.dart';
import 'package:smartico/vendor/view/bottom_nav/vendor_bottom_nav.dart';
import 'banner_card.dart';

// ignore: must_be_immutable
class UserHomePage extends StatelessWidget {
  UserHomePage({super.key});

  FlutterSecureStorage storage = const FlutterSecureStorage();
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final token = await getUserAccesToken();
      log(token.toString(), name: 'usereeeee');
      Provider.of<UserConnectionService>(context, listen: false).userConnection();
      Provider.of<UserProfileProvider>(context, listen: false).getUserDetails();
      Provider.of<GetAllVendor>(context, listen: false).fetchAllVendors();
      context.read<RecentServicesProvider>().fetchAllGigs(context);
      Provider.of<ReservedGigs>(context, listen: false)
          .getReservedGigs(context);
    });
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 16, 81, 135),
            title: const Padding(
                padding: EdgeInsets.only(top: 5, right: 13, left: 13),
                child: CupertinoSearchTextField(
                  backgroundColor: Colors.white,
                )),
            // title: TextButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => MapWidget(),));
            // }, child:Text("mapppp")),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  ColoredBox(
                    color: const Color.fromARGB(255, 16, 81, 135),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          height: 150.0,
                          enlargeCenterPage: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          viewportFraction: 0.8,
                         enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(microseconds: 5000),
                        ),
                        carouselController: carouselController,
                        items: [
                          BannerCard(
                            imageAddress: 'assets/splash/cake banner.jpeg',
                          ),
                          BannerCard(
                            imageAddress: 'assets/splash/painting banner.jpeg',
                          ),
                          BannerCard(
                              imageAddress:
                                  'assets/splash/carpenter banner.webp')
                        ],
                      ),
                    ),
                  ),
                  kHeight10,
                  Card(
                    elevation: 3.0,
                    child: Container(
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/splash/bgImage.jpeg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                      height: height / 10,
                      width: width / 1.07,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Want to be a Vendor',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: height / 22.5,
                            width: width / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    FlutterSecureStorage storage =
                                        const FlutterSecureStorage();
                                    String? vendor = await storage.read(
                                        key: 'vendor_access_token');
                                    if (context.mounted) {}
                                    if (vendor != null) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const VendorBottomNavBar(),
                                          ),
                                          (route) => false);
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VendorSignIn(),
                                          ));
                                    }
                                  },
                                  child: const Text(
                                    "Lets's Get Started",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 17),
                        child: Text(
                          "Services For You",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ViewAllScreen(),
                                ));
                          },
                          child: Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 7, right: 13, left: 13),
                  child: Consumer2<RecentServicesProvider, CommonProvider>(
                    builder: (context, value, value2, child) => value2
                            .shimmerLoading
                        ? const Center(child: SizedBox())
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 3.1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await context
                                      .read<SingleGigDetailsProvider>()
                                      .getGig(
                                          value.allGigs![index].id, context);
                                  // ignore: use_build_context_synchronously
                                  await Provider.of<ReservedGigs>(context,
                                          listen: false)
                                      .getreveiws(value.allGigs![index].id);

                                  if (context.mounted) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ServiceDescriptionScrn(
                                                  isBooked: false,
                                                )));
                                  }
                                },
                                child: SizedBox(
                                    width: width / 2,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: height / 7.7,
                                          width: width / 2.1,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            image: DecorationImage(
                                                image: NetworkImage(value
                                                    .allGigs![index].image),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              value.allGigs![index].title,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(value.allGigs![index].type,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '\u{20B9}${value.allGigs![index].price}',
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            },
                            itemCount: value.allGigs?.length,
                          ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
