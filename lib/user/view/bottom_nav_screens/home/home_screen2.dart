import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';

import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/banner_card.dart';

class HomeScreen2 extends StatelessWidget {
  HomeScreen2({super.key});

  final CarouselController carouselController = CarouselController();
  final List<Widget> icnosList = [
    const Icon(
      Icons.format_paint_rounded,
      size: 35,
      color: Colors.blue,
    ),
    const Icon(
      Icons.plumbing_rounded,
      size: 35,
      color: Colors.blue,
    ),
    const Icon(
      Icons.ac_unit,
      size: 35,
      color: Colors.blue,
    ),
    const Icon(
      Icons.home,
      size: 35,
      color: Colors.blue,
    ),
    const Icon(
      Icons.carpenter,
      size: 35,
      color: Colors.blue,
    ),
    const Icon(
      Icons.car_repair_outlined,
      size: 35,
      color: Colors.blue,
    )
  ];
  final List<Widget> iconNameList = [
    const Text(
      "Painting",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    const Text(
      "Plumber",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    const Text(
      "Ac Repair",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    const Text(
      "Cleaing",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    const Text(
      "Carpenter",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    const Text(
      "Car Repair",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 70,
              child: Image(
                image: AssetImage("assets/splash/off ban.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                kWidth10,
                const SizedBox(
                    height: 35,
                    width: 35,
                    child: Image(
                      image: AssetImage(
                          "assets/splash/Free Image on Pixabay - Tools, Spanner, Mechanic, Metallic.png"),
                      fit: BoxFit.fill,
                    )),
                kWidth20,
                const Text(
                  "ALL",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                kWidth10,
                const Text(
                  "SERVICES",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            kHeight20,
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(),
            ),
            kHeight10,
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Expanded(
                  child: GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 9.0,
                  crossAxisSpacing: 9.0,
                ),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(153, 236, 236, 236),
                    ),
                    height: 70,
                    width: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icnosList[index],
                        iconNameList[index],
                      ],
                    ),
                  ),
                ),
              )),
              // Card(
              //   elevation: 3.0,
              //   child: Container(
              //     decoration: BoxDecoration(
              //         image: const DecorationImage(
              //             image: AssetImage('assets/splash/bgImage.jpeg'),
              //             fit: BoxFit.cover),
              //         borderRadius: BorderRadius.circular(10)),
              //     height: height / 10,
              //     width: width / 1.1 + 20,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const Text(
              //           'Want to be a Vendor',
              //           style: TextStyle(
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.white),
              //         ),
              //         Container(
              //           decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(10)),
              //           height: height / 22.5,
              //           width: width / 2,
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               TextButton(
              //                 onPressed: () async {
              //                   FlutterSecureStorage storage =
              //                       const FlutterSecureStorage();
              //                   String? vendor = await storage.read(
              //                       key: 'vendor_access_token');
              //                   if (context.mounted) {}
              //                   if (vendor != null) {
              //                     // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const VendorBottomNavBar(),), (route) => false);
              //                   } else {
              //                     // Navigator.push(
              //                     //     context,
              //                     //     MaterialPageRoute(
              //                     //       builder: (context) => VendorSignIn(),
              //                     //     ));
              //                   }
              //                 },
              //                 child: const Text(
              //                   "Lets's Get Started",
              //                   style: TextStyle(
              //                     fontSize: 17,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ),
              //               const Icon(
              //                 Icons.arrow_forward,
              //                 size: 20,
              //               )
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   height: 200,
              //   child: Expanded(
              //       child: GridView.builder(
              //     itemCount: 6,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       mainAxisSpacing: 10.0,
              //       crossAxisSpacing: 10.0,
              //     ),
              //     itemBuilder: (context, index) => Container(
              //       height: 100,
              //       width: 50,
              //       color: Colors.red,
              //     ),
              //   )),
              // ),
            ),
            kHeight20,
            const Divider(
              thickness: 6,
              color: Color.fromARGB(255, 238, 238, 238),
            ),
            kHeight10,
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                height: 200.0,
                enlargeCenterPage: false,
                autoPlayCurve: Curves.bounceInOut,
                viewportFraction: 0.9,
                enableInfiniteScroll: false,
                autoPlayAnimationDuration: const Duration(microseconds: 5000),
              ),
              carouselController: carouselController,
              items: [
                BannerCard(
                  imageAddress: 'assets/splash/cake banner.jpeg',
                ),
                BannerCard(
                  imageAddress: 'assets/splash/painting banner.jpeg',
                ),
                BannerCard(imageAddress: 'assets/splash/carpenter banner.webp')
              ],
            ),
            kHeight15,
            const Divider(
              thickness: 6,
              color: Color.fromARGB(255, 238, 238, 238),
            ),
            kHeight20,
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Consumer<RecentServicesProvider>(
                builder: (context, value, child) => 
                 Expanded(
                   child: ListView.builder(itemCount:value.allGigs!.length ,itemBuilder: (context, index) {
                    
                    return Container(
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
                                          );
                                 },),
                 ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
