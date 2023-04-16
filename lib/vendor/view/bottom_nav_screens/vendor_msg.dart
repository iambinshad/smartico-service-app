import 'package:flutter/material.dart';


import 'package:smartico/core/constants.dart';

class VendorMsgScrn extends StatelessWidget {
  const VendorMsgScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 223, 221),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: Text('Messages', style: headText),
      ),
      body: Column(
        children:const [

        ],
      ),
    );
  }
}
