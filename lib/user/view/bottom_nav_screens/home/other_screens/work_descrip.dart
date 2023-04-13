import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/user/booking/book_gig_provider.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/model/booking/booking_model.dart';
import 'package:smartico/user/view/bottom_nav_screens/chat/other_screens/messages.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ServiceDescriptionScrn extends StatefulWidget {
  const ServiceDescriptionScrn({
    super.key,
  });

  @override
  State<ServiceDescriptionScrn> createState() => _ServiceDescriptionScrnState();
}

class _ServiceDescriptionScrnState extends State<ServiceDescriptionScrn> {
  Dio dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
              height: width / 1.1 + 30,
              width: width,
              child: Consumer<SingleGigDetailsProvider>(
                builder: (context, value, child) => FutureBuilder(
                  future: value.gig,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image(
                        image: NetworkImage(snapshot.data!.image),
                        fit: BoxFit.cover,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Center(child: getjobdescriShimmerLoad(width));
                    }
                  },
                ),
              )),
          SizedBox(
            width: width,
            height: width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Consumer<SingleGigDetailsProvider>(
                builder: (context, value, child) => FutureBuilder(
                    future: value.gig,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.title,
                                style: GoogleFonts.playfairDisplay(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: const [
                                  StarIcon(),
                                  StarIcon(),
                                  StarIcon(),
                                  StarIcon(),
                                  StarIcon(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '(70 Reviews)',
                                    style: TextStyle(fontSize: 19),
                                  )
                                ],
                              ),
                              kHeight10,
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/works/profile pic.jpg'),
                                    radius: 22,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(snapshot.data!.vendorId.fullName,
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              kHeight10,
                              Row(
                                children: const [
                                  Icon(
                                    Icons.place_outlined,
                                    color: Color.fromARGB(255, 123, 230, 219),
                                  ),
                                  Text('Golden Estate, Ajah,Logos',
                                      style: TextStyle(fontSize: 19))
                                ],
                              ),
                              kHeight10,
                              Row(
                                children: [
                                  Text(snapshot.data!.type,
                                      style: GoogleFonts.playfairDisplay(
                                          fontSize: 18)),
                                ],
                              ),
                              kHeight10,
                              Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on_outlined,
                                    color: Color.fromARGB(255, 123, 230, 219),
                                  ),
                                  Text("${snapshot.data!.price}",
                                      style: const TextStyle(fontSize: 19))
                                ],
                              ),
                              kHeight10,
                              const Divider(
                                thickness: 1,
                              ),
                              kHeight10,
                              const Text(
                                'Overview',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              kHeight10,
                              Text(snapshot.data!.overview,
                                  style: const TextStyle(fontSize: 19)),
                              kHeight10,
                              const Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              kHeight10,
                              Text(snapshot.data!.description,
                                  style: const TextStyle(fontSize: 19))
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7, right: 8, left: 8),
            child: Consumer<SingleGigDetailsProvider>(
              builder: (context, value, child) => FutureBuilder(
                future: value.gig,
                builder: (context, snapshot) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MessagesScreen(),
                          )),
                      child: Container(
                        height: width / 7.5,
                        width: width / 5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 123, 230, 219))),
                        child: const Icon(
                          Icons.message_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 123, 230, 219),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showConfirmBox(
                            snapshot.data!.price, snapshot.data!.title);
                        final prov =
                            Provider.of<BookGigPrvider>(context, listen: false);
                        prov.gigId = snapshot.data!.id;
                        prov.title = snapshot.data!.title;
                        prov.vendorId = snapshot.data!.vendorId.id;
                        // _openCheckout(snapshot.data!.title,snapshot.data!.price);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 123, 230, 219),
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 4, vertical: width / 27),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      child: const Text(
                        "Pay & Book ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
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
    final prov = Provider.of<BookGigPrvider>(context, listen: false);
    GigBookingModel bookingModel = GigBookingModel(
        vendorId: prov.vendorId.toString(),
        title: prov.title.toString(),
        requirements: response.paymentId.toString(),
        gigId: prov.gigId.toString());
    prov.booking(bookingModel, context);
    // Do something when payment succeeds
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

  void showConfirmBox(price, title) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title:const Text('Confirm Booking'),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyTextFormField(
              controller: Provider.of<BookGigPrvider>(context, listen: false)
                  .bookingRequirements,
              hintText: 'Booking Requirements',
              maxLines: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                confirmClicked(price, title);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      5), // Set the border radius to 0 to create a square button
                ),
                elevation: 5, // Set the elevation of the button
                backgroundColor:
                    mainColor, // Set the background color of the button
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void confirmClicked(price, title) {
    _openCheckout(price, title);
    Navigator.pop(context);
  }
}

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
      size: 25,
      color: Color.fromARGB(255, 123, 230, 219),
    );
  }
}
