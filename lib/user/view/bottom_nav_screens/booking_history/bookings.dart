import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/booking/cancel_booking.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/user/model/booking/reveiw/add_reveiw_model.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/work_descrip.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class BookingHistory extends StatelessWidget {
  BookingHistory({super.key});

  double rating = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CommonProvider>(context, listen: false)
          .setShimmerLoading(true);
      Provider.of<ReservedGigs>(context, listen: false)
          .getReservedGigs(context);

      Provider.of<CommonProvider>(context, listen: false)
          .setShimmerLoading(false);
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Bookings',
          style: headText.copyWith(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
      ),
      body: Column(
        children: [
          Consumer<ReservedGigs>(
              builder: (context, value, child) => Provider.of<CommonProvider>(
                          context,
                          listen: false)
                      .loading
                  ? LoadingAnimationWidget.fourRotatingDots(color: Colors.grey, size: 25.0)
                  : value.reservedGigs!.isEmpty
                      ? const Column(
                          children: [
                            SizedBox(
                              height: 300,
                            ),
                            Center(
                              child: Text(
                                'Bookings Empty',
                              ),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => Card(
                              child: ListTile(
                                onTap: ()async {
                                    await context
                                      .read<SingleGigDetailsProvider>()
                                      .getGig(
                                          value
                                              .reservedGigs![index]!
                                              .gigId
                                              .id,context);
                                  // ignore: use_build_context_synchronously
                                  await Provider.of<ReservedGigs>(context,
                                          listen: false)
                                      .getreveiws(value
                                              .reservedGigs![index]!
                                              .gigId
                                              .id);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDescriptionScrn(isBooked: value.reservedGigs![index]!.status=="Completed"?true:false,index: index,),));
                                },
                                title: Text(value.reservedGigs![index]!.title),
                                leading: Container(
                                  height: 70,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(value
                                              .reservedGigs![index]!
                                              .gigId
                                              .image),
                                          fit: BoxFit.cover)),
                                ),
                                trailing: value.reservedGigs![index]!.status ==
                                        "Completed"
                                    ? ElevatedButton(
                                        onPressed: () {},
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.green)),
                                        child: Text(
                                          value.reservedGigs![index]!.status,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ))
                                    : ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    value.reservedGigs![index]!
                                                                .status ==
                                                            "Cancelled"
                                                        ? Colors.red
                                                        : Colors.blue)),
                                        onPressed: () {
                                          if (value.reservedGigs![index]!
                                                  .status ==
                                              "Reserved") {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Booking Cancel'),
                                                  content: Text(
                                                      'Are You Sure You want to Cancel ${value.reservedGigs![index]!.title} Booking?'),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text('NO')),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          await Provider.of<
                                                                      CancelBookingprovider>(
                                                                  context,
                                                                  listen: false)
                                                              .cancelBooking(
                                                                  context,
                                                                  value
                                                                      .reservedGigs![
                                                                          index]!
                                                                      .id);
                                                          await Provider.of<
                                                                      ReservedGigs>(
                                                                  context,
                                                                  listen: false)
                                                              .getReservedGigs(
                                                                  context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: Text(
                                          value.reservedGigs![index]!.status,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                                subtitle: Text(
                                    "\$${value.reservedGigs![index]!.gigId.price}"),
                              ),
                            ),
                            itemCount: value.reservedGigs!.length,
                          ),
                        )),
        ],
      ),
    );
  }

  Shimmer shimmerLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 70,
                  height: 10,
                  color: Colors.white,
                ),
                Container(
                  width: 50,
                  color: Colors.white,
                  height: 10,
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  color: Colors.white,
                )
              ],
            )
          ],
        ));
  }

  void submitButtonClicked(context, gigId) {
    final provider = Provider.of<ReservedGigs>(context, listen: false);
    ReviewAddingModel reveiw = ReviewAddingModel(
        reviewData: ReviewData(
            gig: gigId,
            rating: provider.rating.toString(),
            title: provider.reviewTitleController.text,
            description: provider.reviewController.text));
    provider.postRating(reveiw);
    provider.reviewController.clear();
    provider.reviewTitleController.clear();
    Navigator.pop(context);
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: 'Reveiw Added',
      ),
    );
  }
}

// ignore: must_be_immutable
class Items extends StatelessWidget {
  Items({super.key, required this.item, required this.value});
  dynamic item;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$item',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          )
        ],
      ),
    );
  }
}
