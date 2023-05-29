import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> controllerr = Completer();

  static const LatLng _center = LatLng(37.335000926, -122.03272188);
  static const CameraPosition initialPosition = CameraPosition(target: LatLng(38.15478,-122.78945 ),zoom: 14.0);

  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // _requestLocationPermission();
  // }

  // Future<void> _requestLocationPermission() async {
  //   final status = await Permission.location.request();
  //   if (status.isGranted) {
  //     // Location permission granted, enable MyLocation layer
  //     setState(() {
  //       _enableMyLocation();
  //     });
  //   } else if (status.isDenied) {
  //     // Location permission denied
  //     // Handle the denied case as needed in your app
  //   } else if (status.isPermanentlyDenied) {
  //     // Location permission permanently denied
  //     // Handle the permanently denied case as needed in your app
  //   }
  // }

  // void _enableMyLocation() async {
  //   final controller = await _controller.future;
  //   controller.setMyLocationEnabled(true);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:initialPosition,
        onMapCreated: (GoogleMapController controller) {
          controllerr.complete(controller) ;
        }),
        
      
    );
  }
}