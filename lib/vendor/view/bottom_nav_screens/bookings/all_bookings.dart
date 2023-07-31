import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/all_booking/all_bookings.dart';
import 'package:smartico/application/vendor/all_booking/cancel_user_bookings.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/vendor/view/bottom_nav_screens/bookings/booked_gigs_details.dart';

class AllBookingTab extends StatelessWidget {
  const AllBookingTab({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AllBookingProvider>(context, listen: false)
          .fetchAllBookings(context);
    });
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Bookings',
            style: headText.copyWith(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 16, 81, 135),
          centerTitle: true),
      body: Consumer<AllBookingProvider>(
        builder: (context, value, child) => value.allBookings!.isEmpty
            ? Center(
                child: Text(
                  'No One Booked Yet!',
                  style: normalText,
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookedGigsFullDetails(
                                      index: index,
                                      title: value.allBookings![index].title!),
                                )),
                            leading: CachedNetworkImage(
                              placeholder: (context, url) => const SizedBox(
                                height: 50,
                                width: 80,
                              ),
                              imageUrl: value
                                      .allBookings![index].gigId?.image ??
                                  "https://cdn4.iconfinder.com/data/icons/ui-beast-3/32/ui-49-4096.png",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(7)),
                              ),
                            ),
                            title: Text(
                              value.allBookings![index].title!,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                "Payment Id : ${value.allBookings![index].requirements}"),
                            trailing: value.allBookings![index].status ==
                                    'Completed'
                                ? TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.green)),
                                    child: const Text(
                                      'Completed',
                                      style: TextStyle(color: Colors.white),
                                    ))
                                : TextButton(
                                    onPressed: () {
                                      if (value.allBookings![index].status ==
                                          'Reserved') {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                              title: Text(
                                                value
                                                    .allBookings![index].title!,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      await Provider.of<
                                                                  AllBookingProvider>(
                                                              context,
                                                              listen: false)
                                                          .completeService(
                                                              context,
                                                              value
                                                                  .allBookings![
                                                                      index]
                                                                  .id);
                                                  if(context.mounted){    await Provider.of<
                                                                  AllBookingProvider>(
                                                              context,
                                                              listen: false)
                                                          .fetchAllBookings(
                                                              context);}
                                                      if(context.mounted){Navigator.pop(context);}
                                                    },
                                                    style: ButtonStyle(
                                                        shape: MaterialStatePropertyAll(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5))),
                                                        backgroundColor:
                                                            const MaterialStatePropertyAll(
                                                          Colors.green,
                                                        )),
                                                    child: const Text(
                                                      'Work Completed',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      await Provider.of<
                                                                  CancelUserBookingsProvider>(
                                                              context,
                                                              listen: false)
                                                          .cancelUserBooking(
                                                              context,
                                                              value
                                                                  .allBookings![
                                                                      index]
                                                                  .id);
                                                      if (context.mounted) {
                                                        await Provider.of<
                                                                    AllBookingProvider>(
                                                                context,
                                                                listen: false)
                                                            .fetchAllBookings(
                                                                context);
                                                        
                                                      }
                                                     if(context.mounted){ Navigator.pop(context);}
                                                    },
                                                    style: ButtonStyle(
                                                        shape: MaterialStatePropertyAll(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5))),
                                                        backgroundColor:
                                                            const MaterialStatePropertyAll(
                                                          Colors.red,
                                                        )),
                                                    child: const Text(
                                                      'Cancel Work',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                              content: Text(
                                                  "Click Cancel Work for canceling ${value.allBookings![index].title!} work or click work complete if your work done")),
                                        );
                                      }
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        backgroundColor:
                                            MaterialStatePropertyAll(value
                                                        .allBookings![index]
                                                        .status ==
                                                    'Cancelled'
                                                ? Colors.red
                                                : Colors.blue)),
                                    child: Text(
                                      value.allBookings![index].status!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  )),
                      ),
                    ],
                  );
                },
                itemCount: value.allBookings!.length,
              ),
      ),
    );
  }
}
