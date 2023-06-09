import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/work_descrip.dart';

class AllCategroryList extends StatelessWidget {
  AllCategroryList({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CommonProvider>(context, listen: false)
          .setShimmerLoading(true);
          Provider.of<RecentServicesProvider>(context, listen: false).showList=Provider.of<RecentServicesProvider>(context, listen: false).allGigs;
      Future.delayed(const Duration(milliseconds: 700), () {
        context.read<CommonProvider>().setShimmerLoading(false);
      });
    });
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 16, 81, 135),
        elevation: 1,
        centerTitle: true,
        title:  Text(
          'All Services',
          style:headText.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
           ColoredBox(
            color:const Color.fromARGB(255, 16, 81, 135),
            child: Padding(
                padding: const EdgeInsets.only(right: 13, left: 13, bottom: 5),
                child: Consumer<RecentServicesProvider>(
                  builder: (context, values, child) => 
                  CupertinoSearchTextField(
                    onChanged: (value) =>values.filterGigList(value) ,
                    backgroundColor: Colors.white,
                  ),
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 10,
                left: 10,
              ),
              child: Consumer2<RecentServicesProvider, CommonProvider>(
                builder: (context, value, value2, child) => value2.shimmerLoading
                        ? Center(child: LoadingAnimationWidget.fourRotatingDots(color: Colors.grey, size: 25.0))
                        :  ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                            onTap: () async {
                              await context
                                  .read<SingleGigDetailsProvider>()
                                  .getGig(value.showList![index].id, context);
                                  await Provider.of<ReservedGigs>(context,
                                          listen: false)
                                      .getreveiws(value.allGigs![index].id);
                              if (context.mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                           const ServiceDescriptionScrn(isBooked: false,),
                                    ));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            image: DecorationImage(
                                                image: NetworkImage(value
                                                    .showList![index].image),
                                                fit: BoxFit.cover)),
                                        height: width / 2.9,
                                        width: width / 3.2,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: width / 3,
                                    width: width / 1.9,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              value.showList![index].title,
                                              style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              value.showList![index].type,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.star_rate_rounded,
                                              color: Colors.yellow,
                                              size: 23,
                                            ),
                                            Text(
                                              '4.9(1.2k + reviews)',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
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
                                              " ${value.showList![index].price}",
                                              style:const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.blue,
                                              size: 23,
                                            ),
                                            Text(
                                              "383",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                  },
                  itemCount: value.showList!.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
