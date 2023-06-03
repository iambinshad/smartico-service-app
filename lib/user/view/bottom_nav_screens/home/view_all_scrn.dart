import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/work_descrip.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CommonProvider>(context, listen: false)
          .setShimmerLoading(true);
      Future.delayed(const Duration(milliseconds: 700), () {
        context.read<CommonProvider>().setShimmerLoading(false);
      });
    });
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Services For You',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer2<RecentServicesProvider, CommonProvider>(
        builder: (context, value, value2, child) => ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: GestureDetector(
                onTap: () async {
                  await context
                      .read<SingleGigDetailsProvider>()
                      .getGig(value.allGigs![index].id, context);
                  if(context.mounted){await Provider.of<ReservedGigs>(context, listen: false)
                      .getreveiws(value.allGigs![index].id);}
                      await Provider.of<ReservedGigs>(context,
                                          listen: false)
                                      .getreveiws(value.allGigs![index].id);

                  if (context.mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ServiceDescriptionScrn(isBooked: false,),
                        ));
                  }
                },
                child: value2.shimmerLoading
                    ? getRecentShimmer(height, width)
                    : Card(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: height / 4,
                                width: width / 1.10,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            value.allGigs![index].image),
                                        fit: BoxFit.fill)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      value.allGigs![index].title,
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.blue,
                                        ),
                                        Text(
                                          '5.0',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      '\$${value.allGigs![index].price}',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            );
          },
          itemCount: value.allGigs!.length,
        ),
      ),
    );
  }

  Shimmer getRecentShimmer(height, width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          children: [
            Container(
              height: height / 4,
              width: width / 1.10,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 15,
                    color: Colors.white,
                  ),
                  kHeight10,
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 15,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 15,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
