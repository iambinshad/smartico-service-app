import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/core/widgets.dart';

class BannerCard extends StatelessWidget {
  BannerCard({
    required this.imageAddress,
    super.key,
  });
  String imageAddress;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(imageAddress), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
  Shimmer getRecentShimmer(height, width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          children: [
            Container(
              height: height / 4,
              width: width / 1.10,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 15,
                    color: Colors.white,
                  ),
                  kHeight10,
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 15,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 15,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }