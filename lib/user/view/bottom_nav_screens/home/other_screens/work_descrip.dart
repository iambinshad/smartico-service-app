import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/bottom_nav_screens/chat/other_screens/messages.dart';

class ServiceDescriptionScrn extends StatefulWidget {
   ServiceDescriptionScrn({
    super.key,
  });




  @override
  State<ServiceDescriptionScrn> createState() => _ServiceDescriptionScrnState();
}

class _ServiceDescriptionScrnState extends State<ServiceDescriptionScrn> {
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
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); 
  }
 final _razorpay = Razorpay();
 var options = {
  'key': 'LcpMGI7JTMlHYh',
  'amount': 100,
  'name': 'Acme Corp.',
  'description': 'Fine T-Shirt',
  'prefill': {
    'contact': '8888888888',
    'email': 'test@razorpay.com'
  }
};
 
 
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                      return  Center(child: getjobdescriShimmerLoad(width));
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
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              kHeight10,
                              Text(snapshot.data!.overview,
                                  style: const TextStyle(fontSize: 19)),
                              kHeight10,
                              const Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
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
            child: Row(
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
                            color: const Color.fromARGB(255, 123, 230, 219))),
                    child: const Icon(
                      Icons.message_rounded,
                      size: 30,
                      color: Color.fromARGB(255, 123, 230, 219),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _razorpay.open(options);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 123, 230, 219),
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
          )
        ],
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
  // Do something when payment succeeds
}

void _handlePaymentError(PaymentFailureResponse response) {
  // Do something when payment fails
}

void _handleExternalWallet(ExternalWalletResponse response) {
  // Do something when an external wallet is selected
}

  Shimmer getjobdescriShimmerLoad(width){
    return Shimmer.fromColors( baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!,
    child:Container(
        height: width / 1.1 + 30,
        width: width,
        color: Colors.white,
        ),
    );
  }
}

class Containerr extends StatelessWidget {
   Containerr({
    super.key,
    this.height,this.width,   this.color = Colors.white
  });
dynamic height;
dynamic width;
Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,width: width,
      color:color,
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
