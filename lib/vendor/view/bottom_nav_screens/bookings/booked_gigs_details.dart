import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/all_booking/all_bookings.dart';
import 'package:smartico/application/vendor/gig_provider/show_all_gig_provider.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/theme/access_token/token.dart';
import 'package:smartico/core/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smartico/user/controller/chat_function/chat_methods.dart';
import 'package:smartico/user/model/chat/chating_vendor_model.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/chats/messages.dart';

class BookedGigsFullDetails extends StatelessWidget {
  BookedGigsFullDetails({super.key, required this.index, required this.title});

  int index;
  String title;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
      ),
      body: ListView(
        children: [
          SizedBox(
              height: width / 1.5,
              width: width,
              child: Consumer<AllBookingProvider>(
                builder: (context, value, child) => Image(
                  image: NetworkImage(value.allBookings?[index].gigId?.image ??
                      "https://cdn4.iconfinder.com/data/icons/ui-beast-3/32/ui-49-4096.png"),
                  fit: BoxFit.cover,
                ),
              )),
          Card(
            child: SizedBox(
              // width: width,
              // height: doub,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Consumer2<ShowAllGigsProvider, AllBookingProvider>(
                  builder: (context, value, value2, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.vendorGigs![index].title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      kHeight10,
                      Row(
                        children: [
                          Text(value.vendorGigs![index].type,
                              style: normalText),
                        ],
                      ),
                      kHeight10,
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on_outlined,
                            color: Color.fromARGB(255, 123, 230, 219),
                          ),
                          Text("${value.vendorGigs![index].price}",
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
                      Text(value.vendorGigs![index].overview,
                          style: const TextStyle(fontSize: 19)),
                      kHeight10,
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      kHeight10,
                      Text(value.vendorGigs![index].description,
                          style: const TextStyle(fontSize: 19)),
                      kHeight10,
                      const Divider(
                        thickness: 5,
                        color: Colors.grey,
                      ),
                      kHeight10,
                      Text(
                        "Customer Details",
                        style: normalText,
                      ),
                      kHeight15,
                      Row(
                        children: [
                          value2.allBookings?[index].userId?.profilePhoto ==
                                  null
                              ? const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/splash/unknown.jpg"),
                                  radius: 22,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(value2
                                      .allBookings![index]
                                      .userId!
                                      .profilePhoto!),
                                  radius: 22,
                                ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(value2.allBookings![index].userId!.fullName!,
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          CircleAvatar(
                              child: IconButton(
                                  onPressed: () async {
                                    
                                    if (value2.allBookings![index].userId!
                                            .location !=
                                        null) {
                                      String locationName = value2
                                          .allBookings![index].userId!.location;
                                      String url =
                                          'https://www.google.com/maps/search/?api=1&query=$locationName';

                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        if(context.mounted){showTopSnackBar(
                                          Overlay.of(context),
                                          const CustomSnackBar.error(
                                            message: 'Map Launch Error',
                                          ),
                                        );}
                                        throw 'Could not launch $url';
                                      }
                                    } else {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.info(
                                          message: 'Location is empty!',
                                        ),
                                      );
                                    }
                                  },
                                  icon:
                                      const Icon(Icons.location_on_outlined))),
                          const Spacer(),
                          CircleAvatar(
                            child: IconButton(
                                onPressed: () async {
                                  String currentVendorId =
                                      await getCurrentVendorId();
                                 
                                  final pro= Provider.of<AllBookingProvider>(
                                      context,
                                      listen: false);
                                  
                                  String chatRoomId = ChatMethods().checkingId(
                                      vendorId: currentVendorId,
                                      currentUser: pro.allBookings![index].id!);
                                  ChatingUser chatingUser = ChatingUser(
                                    userName: pro
                                        .allBookings![index].userId!.fullName!,
                                    id: pro.allBookings![index].id!,
                                  );

                                  if (context.mounted) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VendorMessagesScreen(
                                                  chatRoomId: chatRoomId,
                                                  chatingUser: chatingUser,
                                                  currentVendorId:
                                                      currentVendorId,
                                                  profilePic: pro
                                                      .allBookings![index]
                                                      .userId!
                                                      .profilePhoto,
                                                )));
                                  }
                                },
                                icon: const Icon(Icons.message_outlined)),
                          ),
                        ],
                      ),
                      // Text(value2.allBookings[index].userId!.)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
