import 'package:flutter/material.dart';
import 'package:smartico/core/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: mainColor,title: const Text('Settings'),),
    );
  }
}