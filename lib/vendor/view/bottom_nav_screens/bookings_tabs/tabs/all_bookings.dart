import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/all_booking/all_bookings.dart';
import 'package:smartico/application/vendor/all_booking/cancel_user_bookings.dart';
import 'package:smartico/core/widgets.dart';

class AllBookingTab extends StatelessWidget {
  const AllBookingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AllBookingProvider>(
      builder: (context, value, child) =>value.allBookings?.length==0?Center(child: Text('Bookings Not Found!'),): ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                    title: Text(
                      value.allBookings![index].title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Payment Id : ${value.allBookings![index].requirements}"),
                    trailing: value.allBookings![index].status == 'Completed'
                        ? TextButton(
                            onPressed: () {},
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.green)),
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
                                        value.allBookings![index].title,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Provider.of<AllBookingProvider>(
                                                        context,
                                                        listen: false)
                                                    .completeService(
                                                        context,
                                                        value
                                                            .allBookings![index]
                                                            .id);
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
                                                    color: Colors.white),
                                              )),
                                          kWidth10,
                                          ElevatedButton(
                                              onPressed: () {
                                                Provider.of<CancelUserBookingsProvider>(
                                                        context,
                                                        listen: false)
                                                    .cancelUserBooking(
                                                        context,
                                                        value
                                                            .allBookings![index]
                                                            .id);
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
                                                    color: Colors.white),
                                              ))
                                        ],
                                      )),
                                );
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    value.allBookings![index].status ==
                                            'Cancelled'
                                        ? Colors.red
                                        : Colors.blue)),
                            child: Text(
                              value.allBookings![index].status,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
              ),
            ],
          );
        },
        itemCount: value.allBookings!.length,
      ),
    );
  }
}
