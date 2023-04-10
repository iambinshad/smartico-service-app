  
  import 'package:shimmer/shimmer.dart';
  import 'package:flutter/material.dart';
import 'package:smartico/core/widgets.dart';

Shimmer getGridShimmer(width, height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
          width: width / 2,
          child: Column(
            children: [
              Container(
                height: height / 7.7,
                width: width / 2.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.white),
              ),
              kHeight10,
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 120,
                    color: Colors.white,
                  )
                ],
              ),
              kHeight10,
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 70,
                    color: Colors.white,
                  )
                ],
              ),
              kHeight10,
              // Row(
              //   children: const [
              //     Icon(
              //       Icons.star_rate_rounded,
              //       color: Colors.yellow,
              //       size: 23,
              //     ),
              //     Text(
              //       '4.9(1.2k + reviews)',
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 50,
                    color: Colors.white,
                  )
                ],
              ),
            ],
          )),
    );
  }