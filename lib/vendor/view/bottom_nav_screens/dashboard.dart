import 'package:flutter/material.dart';


class DashboardScrn extends StatefulWidget {
  const DashboardScrn({super.key});

  @override
  State<DashboardScrn> createState() => _DashboardScrnState();
}

class _DashboardScrnState extends State<DashboardScrn> {
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
  
    
    return  Scaffold(
      appBar: AppBar(),
      body:const Center(child: Text('Dashboard')),
    );
  }
}