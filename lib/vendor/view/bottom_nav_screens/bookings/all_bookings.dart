import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/all_booking/all_bookings.dart';
import 'package:smartico/application/vendor/all_booking/cancel_user_bookings.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
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
            style: normalText,
          ),
          backgroundColor: mainColor,
          centerTitle: true),
      body: Consumer<AllBookingProvider>(
        builder: (context, value, child) => value.allBookings!.isEmpty
            ? const Center(
                child: Text('No One Booked Yet!'),
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
                            leading: Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(value
                                          .allBookings![index].gigId!.image!),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(7)),
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
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
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
                                              content: Row(
                                                children: [
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
                                                        await Provider.of<
                                                                    AllBookingProvider>(
                                                                context,
                                                                listen: false)
                                                            .fetchAllBookings(
                                                                context);
                                                        Navigator.pop(context);
                                                      },
                                                      style: const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                        Colors.green,
                                                      )),
                                                      child: const Text(
                                                        'Work Completed',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                       await Provider.of<CancelUserBookingsProvider>(
                                                                context,
                                                                listen: false)
                                                            .cancelUserBooking(
                                                                context,
                                                                value
                                                                    .allBookings![
                                                                        index]
                                                                    .id);
                                                        await Provider.of<
                                                                    AllBookingProvider>(
                                                                context,
                                                                listen: false)
                                                            .fetchAllBookings(
                                                                context);
                                                        Navigator.pop(context);
                                                      },
                                                      style: const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                        Colors.red,
                                                      )),
                                                      child: const Text(
                                                        'Cancel Work',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ))
                                                ],
                                              )),
                                        );
                                      }
                                    },
                                    style: ButtonStyle(
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
