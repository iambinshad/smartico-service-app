import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';


class AllCategroryList extends StatelessWidget {
  const AllCategroryList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title:SearchBarAnimation(
                          textEditingController: TextEditingController(),
                          isOriginalAnimation: true,
                          enableKeyboardFocus: true,
                          trailingWidget: const Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.black,
                          ),
                          secondaryButtonWidget: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                          buttonWidget: const Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.black,
                          ),
                        ), 
      ),
    );
  }
}