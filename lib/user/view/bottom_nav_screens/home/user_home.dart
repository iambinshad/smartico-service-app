import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/all_vendor_prov.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/work_descrip.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/view_all_scrn.dart';
import 'package:smartico/vendor/view/authentication/vendor_sign_in.dart';
import 'package:smartico/vendor/view/bottom_nav/vendor_bottom_nav.dart';

import 'banner_card.dart';
import 'other_screens/shimmer_page.dart';

class UserHomePage extends StatelessWidget {
  UserHomePage({super.key});
  List serviceCategoryIcons = <Widget>[
    const Icon(Icons.plumbing),
    const Icon(Icons.delivery_dining_sharp),
    const Icon(Icons.cake),
    const Icon(Icons.format_paint),
    const Icon(Icons.tv_rounded),
    const Icon(Icons.electrical_services_outlined),
    const Icon(Icons.iron),
    const Icon(Icons.dry_cleaning),
  ];
  FlutterSecureStorage storage = FlutterSecureStorage();
  List serviceCategoryNames = [
    'Plumber',
    'Delivery',
    'Cake Maker',
    'Painter',
    'Tv repair',
    'Electrician',
    'Dress iron',
    'Dress dry Clean'
  ];
  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      
      print(await storage.readAll());
      context.read<CommonProvider>().setShimmerLoading(true);
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
            backgroundColor: const Color.fromARGB(255, 121, 216, 206),
            title: const Padding(
                padding: EdgeInsets.only(top: 5, right: 13, left: 13),
                child: CupertinoSearchTextField(
                  backgroundColor: Colors.white,
                )),
          ),
          body: Column(
            children: [
              ColoredBox(
                color: const Color.fromARGB(255, 121, 216, 206),
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
                          imageAddress: 'assets/splash/carpenter banner.webp')
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
                  width: width / 1.1,
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
                                String token = await getVendorAccesToken();

                                if (token != '' && context.mounted) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const VendorBottomNavBar(),
                                      ),
                                      (route) => false);
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VendorSignIn(),
                                      ),
                                      (route) => false);
                                }
                              },
                              child: const Text(
                                "Lets's Get Started",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
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
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 6,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return SizedBox(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: CircleAvatar(
                              radius: 32,
                              child: serviceCategoryIcons[index],
                            ),
                          ),
                          Text(
                            serviceCategoryNames[index],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ));
                    },
                    itemCount: 8,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 17),
                    child: Text(
                      "Recomended services",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ViewAllScreen(),
                                ));
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 123, 230, 219),
                            ),
                          ))),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 7, right: 13, left: 13),
                  child: Consumer2<RecentServicesProvider, CommonProvider>(
                    builder: (context, value, value2, child) =>
                        GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 3.1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return value2.shimmerLoading
                            ? getGridShimmer(width, height)
                            : GestureDetector(
                                onTap: () async {
                                  await context
                                      .read<SingleGigDetailsProvider>()
                                      .getGig(
                                          value.allGigs![index].id, context);

                                  if (context.mounted) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ServiceDescriptionScrn(),
                                        ));
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
                                                  color: Colors.blue,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(value.allGigs![index].type,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.monetization_on,
                                              color: Color.fromARGB(
                                                  255, 58, 201, 15),
                                              size: 23,
                                            ),
                                            Text(
                                              '${value.allGigs![index].price}',
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
