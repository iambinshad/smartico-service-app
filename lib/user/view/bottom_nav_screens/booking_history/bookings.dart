import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/booking/cancel_booking.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/model/booking/reveiw/add_reveiw_model.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/rating_review.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
        title: const Text('Bookings'),
        backgroundColor: mainColor,
      ),
      body: Column(
        children: [
          ListTile(
            leading: SizedBox(
                width: 100,
                child: Text(
                  'Booked Gigs',
                  style: normalText,
                )),
            title: Text(
              'Details',
              style: normalText,
            ),
            trailing: TextButton(
              child: Text("Status   ",
                  style: normalText.copyWith(color: Colors.black)),
              onPressed: () {},
            ),
          ),
          Consumer<ReservedGigs>(
              builder: (context, value, child) => Provider.of<CommonProvider>(
                          context,
                          listen: false)
                      .loading
                  ? shimmerLoading()
                  : Expanded(
                      child: value.reservedGigs == null
                          ? const Center(
                              child: Text(
                                'Empty Bookings',
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) => ListTile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        title: Center(
                                            child: Text(
                                          value.reservedGigs![index]!.title,
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        children: [
                                          Items(
                                            item: 'Payment Id :',
                                            value: value.reservedGigs![index]!
                                                .requirements,
                                          ),
                                          Items(
                                            item: 'Type :',
                                            value: value.reservedGigs![index]
                                                ?.gigId.type,
                                          ),
                                          Items(
                                            item: 'Price :\$',
                                            value:
                                                "${value.reservedGigs![index]?.gigId.price}",
                                          ),
                                          Items(
                                            item: 'Status :',
                                            value:
                                                "${value.reservedGigs![index]?.status}",
                                          ),
                                          value.reservedGigs![index]?.status ==
                                                  'Completed'
                                              ? Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  side: BorderSide(
                                                                      color:
                                                                          mainColor)))),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              SimpleDialog(
                                                            title: const Center(
                                                              child: Text(
                                                                  'Rating'),
                                                            ),
                                                            children: [
                                                              Center(
                                                                child: RatingBar
                                                                    .builder(
                                                                  allowHalfRating:
                                                                      true,
                                                                  glowColor:
                                                                      mainColor,
                                                                  initialRating:
                                                                      3,
                                                                  itemBuilder: (context,
                                                                          index) =>
                                                                      const Icon(
                                                                    Icons.star,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            230,
                                                                            209,
                                                                            23),
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    value.setRating =
                                                                        rating;
                                                                  },
                                                                  updateOnDrag:
                                                                      true,
                                                                  minRating: 1,
                                                                  glow: true,
                                                                  itemSize: 30,
                                                                  itemPadding:
                                                                      const EdgeInsets
                                                                          .all(3),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    MyTextFormField(
                                                                  controller: value
                                                                      .reviewTitleController,
                                                                  maxLines: 1,
                                                                  hintText:
                                                                      'Title',
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    MyTextFormField(
                                                                  controller: value
                                                                      .reviewController,
                                                                  maxLines: 3,
                                                                  hintText:
                                                                      'Review',
                                                                ),
                                                              ),
                                                              Center(
                                                                  child:
                                                                      ElevatedButton(
                                                                onPressed: () {
                                                                  submitButtonClicked(
                                                                      context,value.reservedGigs![index]!.gigId.id);
                                                                },
                                                                style: ButtonStyle(
                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5.0),
                                                                        side: BorderSide(
                                                                            color:
                                                                                mainColor)))),
                                                                child:
                                                                   const  Text(
                                                                  'Submit',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ))
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Add Review',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )),
                                                )
                                              : const SizedBox(),
                                        ],
                                      );
                                    },
                                  );
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
                                                        onPressed: () {
                                                          Provider.of<CancelBookingprovider>(
                                                                  context,
                                                                  listen: false)
                                                              .cancelBooking(
                                                                  context,
                                                                  value
                                                                      .reservedGigs![
                                                                          index]!
                                                                      .id);
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

  void submitButtonClicked(context,gigId) {
    final provider = Provider.of<ReservedGigs>(context, listen: false);
    ReviewAddingModel reveiw =ReviewAddingModel(reviewData: ReviewData(gig: gigId, rating:provider.rating.toString(), title: provider.reviewTitleController.text, description: provider.reviewController.text));
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

class Items extends StatelessWidget {
  Items({super.key, required this.item, required this.value});
  dynamic item;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$item',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value)
      ],
    );
  }
}
