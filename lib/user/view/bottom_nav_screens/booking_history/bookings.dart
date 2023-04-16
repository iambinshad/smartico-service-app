import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/core/constants.dart';

class BookingHistory extends StatelessWidget {
  const BookingHistory({super.key});

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
      body: Consumer<ReservedGigs>(
          builder: (context, value, child) =>
              Provider.of<CommonProvider>(context, listen: false).loading
                  ? shimmerLoading()
                  : ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(value.reservedGigs![index].title),
                        trailing: Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      value.reservedGigs![index].gigId.image),
                                  fit: BoxFit.fill)),
                        ),
                        subtitle: Text(value.reservedGigs![index].requirements),
                      ),
                      itemCount: value.reservedGigs!.length,
                    )),
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
}
