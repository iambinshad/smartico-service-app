import 'package:flutter/material.dart';

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