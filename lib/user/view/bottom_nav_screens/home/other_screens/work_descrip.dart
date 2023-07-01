import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/user/booking/book_gig_provider.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/controller/chat_function/chat_methods.dart';
import 'package:smartico/user/model/booking/booking_model.dart';
import 'package:smartico/user/model/booking/reveiw/add_reveiw_model.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import 'package:smartico/user/view/bottom_nav_screens/chat/messages.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/rating_review.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'confirm_success.dart';

class ServiceDescriptionScrn extends StatefulWidget {
  const ServiceDescriptionScrn({
    super.key,
    this.isBooked,
    this.index,
  });

  final isBooked;
  final index;

  @override
  State<ServiceDescriptionScrn> createState() => _ServiceDescriptionScrnState();
}

class _ServiceDescriptionScrnState extends State<ServiceDescriptionScrn> {
  List<String> offerText1 = [
    "Save 15% quotes every order",
    "Buy More Save More",
    "Assured cashback on Paytm",
    "15% off on Kotak Debit cards",
    "15% off on Kotak Credit card"
  ];
  List<String> offerText2 = [
    "Get Plus now",
    "30% off 2nd item onwards",
    "Up to 300 off",
    "15% off up to INR 250",
    "15% off up to INR 250"
  ];

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  final _razorpay = Razorpay();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Consumer<SingleGigDetailsProvider>(
          builder: (context, value, child) => FutureBuilder(
            future: value.gig,
            builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  confirmClicked(snapshot.data!.price, snapshot.data!.title);
                  final prov =
                      Provider.of<BookGigPrvider>(context, listen: false);
                  prov.gigId = snapshot.data!.id;
                  prov.title = snapshot.data!.title;
                  prov.vendorId = snapshot.data!.vendorId.id;
                  // _openCheckout(snapshot.data!.title,snapshot.data!.price);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 123, 230, 219),
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 5, vertical: width / 27),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                child: const Text(
                  "Pay & Book ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: ListView(
          // physics: NeverScrollableScrollPhysics(),
          children: [
            Consumer<SingleGigDetailsProvider>(
              builder: (context, value, child) => FutureBuilder(
                future: value.gig,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: width / 1.7,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data!.image),
                              fit: BoxFit.fill)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.black,
                                    size: 18,
                                  )),
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } 
                  else {
                    return Container(
                      height: height,
                      alignment: Alignment.center,
                      child:  LoadingAnimationWidget.fourRotatingDots(
                            color: Colors.grey, size: 25),
                    );
                  }
                },
              ),
            ),
            kHeight10,
            SizedBox(
              width: width,
              height: height - width / 1.7,
              child: Consumer<SingleGigDetailsProvider>(
                builder: (context, value, child) => FutureBuilder(
                    future: value.gig,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // snapshot.data!.title,
                                    "${snapshot.data!.title}-",
                                    style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data!.type,
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              kHeight10,
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                             WorkReviewScreen(status:widget.isBooked),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    const StarIcon(),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Consumer<ReservedGigs>(
                                      builder: (context, value, child) => Text(
                                        " (${value.reveiws == null ? 0 : value.reveiws!.length} reveiw)",
                                        style: const TextStyle(fontSize: 19),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              kHeight10,
                              Row(
                                children: [
                                  Text("\u{20B9}${snapshot.data!.price}",
                                      style: const TextStyle(fontSize: 19)),
                                  kWidth10,
                                  Text("\u{20B9}${snapshot.data!.price + 49}",
                                      style: const TextStyle(
                                          fontSize: 19,
                                          decoration:
                                              TextDecoration.lineThrough))
                                ],
                              ),
                              const Text(
                                'Overview',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              kHeight10,
                              Text(snapshot.data!.overview,
                                  style: const TextStyle(fontSize: 17)),
                              kHeight10,
                              const Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              kHeight10,
                              Text(snapshot.data!.description,
                                  style: const TextStyle(fontSize: 17)),
                              kHeight10,
                              const Divider(),
                              kHeight15,
                              Container(
                                width: width / 1.2,
                                height: width / 5.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 240, 240, 240)),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.verified,
                                              color: Colors.green,
                                              size: 15,
                                            ),
                                            Text(
                                              "Smartico Cover",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Verified repair quotes & 30 days warrenty",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_forward_ios_rounded)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              kHeight10,
                              SizedBox(
                                width: double.infinity,
                                height: height / 12,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                          itemCount: 5,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Container(
                                                  width: width / 1.7,
                                                  height: width / 8.5,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        const Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .local_offer_rounded,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              offerText1[index],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(offerText2[
                                                                index])
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                kWidth10,
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              kHeight10,
                              const Divider(
                                thickness: 1,
                              ),
                              kHeight10,
                              Row(
                                children: [
                                  snapshot.data!.vendorId.profilePhoto == null
                                      ? const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/splash/unknown.jpg"),
                                          radius: 22,
                                        )
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(snapshot
                                              .data!.vendorId.profilePhoto!),
                                          radius: 22,
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(snapshot.data!.vendorId.fullName,
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () async {
                                          final currentUserId =
                                              await getCurrentUserId();
                                          ChatingVendor chatingVendor =
                                              ChatingVendor(
                                                  id: snapshot
                                                      .data!.vendorId.id,
                                                  vendorName: snapshot
                                                      .data!.vendorId.fullName);

                                          final chatRoomId = ChatMethods()
                                              .checkingId(
                                                  vendorId: snapshot
                                                      .data!.vendorId.id,
                                                  currentUser: currentUserId);

                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UserMessagesScreen(
                                                  chatRoomId: chatRoomId,
                                                  chatingVendor: chatingVendor,
                                                  currentUserId: currentUserId,
                                                  profilePic: snapshot.data!
                                                      .vendorId.profilePhoto,
                                                ),
                                              ));
                                        },
                                        icon:
                                            const Icon(Icons.message_outlined)),
                                  )
                                ],
                              ),
                             
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCheckout(price, title) {
    var options = {
      'key': 'rzp_test_2cg0OeQbAa5nGA',
      'amount': '${price * 100}',
      'name': '$title',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const BookingStatus()),
        (Route<dynamic> route) => false);
    final prov = Provider.of<BookGigPrvider>(context, listen: false);
    GigBookingModel bookingModel = GigBookingModel(
        vendorId: prov.vendorId.toString(),
        title: prov.title.toString(),
        requirements: response.paymentId.toString(),
        gigId: prov.gigId.toString());
    prov.booking(bookingModel, context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Payment Failed',
      ),
    );
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Shimmer getjobdescriShimmerLoad(width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: width / 1.1 + 30,
        width: width,
        color: Colors.white,
      ),
    );
  }

  void confirmClicked(price, title) {
    _openCheckout(price, title);
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
class Containerr extends StatelessWidget {
  Containerr({super.key, this.height, this.width, this.color = Colors.white});
  dynamic height;
  dynamic width;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}

class StarIcon extends StatelessWidget {
  const StarIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.star_rate_rounded,
      size: 23,
      color: Colors.black,
    );
  }
}
