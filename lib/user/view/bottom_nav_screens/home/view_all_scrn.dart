import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/work_descrip.dart';

import 'widget.dart';

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
        automaticallyImplyLeading: false,
        leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Services For You',
          style: headText.copyWith(color: Colors.white),
        ),
        bottom:  PreferredSize(preferredSize: const Size.fromHeight(30), child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Consumer<RecentServicesProvider>(
                  builder: (context, values, child) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CupertinoSearchTextField(
                      onChanged: (value) => values.filterGigList(value),
                      backgroundColor: Colors.white,
                    ),
                  ),
                )
        )),
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
                      .getGig(value.showList![index].id, context);
                  if (context.mounted) {
                    await Provider.of<ReservedGigs>(context, listen: false)
                        .getreveiws(value.showList![index].id);
                  }
                  if(context.mounted){await Provider.of<ReservedGigs>(context, listen: false)
                      .getreveiws(value.showList![index].id);}

                  if (context.mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ServiceDescriptionScrn(
                            isBooked: false,
                          ),
                        ));
                  }
                },
                child: value2.shimmerLoading
                    ? getRecentShimmer(height, width)
                    : Card(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                placeholder: (context, url) =>SizedBox( height: height / 4,
                                  width: width / 1.10,) ,
                                imageUrl:value.showList![index].image,
                                imageBuilder: (context, imageProvider) => 
                                 Container(
                                  height: height / 4,
                                  width: width / 1.10,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      image: DecorationImage(
                                          image:imageProvider,
                                          fit: BoxFit.fill)),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      value.showList![index].title,
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      children: [
                                        Icon(Icons.star_rounded,
                                            color: Colors.black, size: 19),
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
                                      '\$${value.showList![index].price}',
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
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
          itemCount: value.showList!.length,
        ),
      ),
    );
  }


}
