import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartico/vendor/controller/gig/show_all_gigs.dart';
import 'package:smartico/vendor/model/show_all_gig/show_all_gig.dart';

class ShowAllGigsProvider with ChangeNotifier{
  List<GigResModel>? vendorGigs = [];

  Future<void>callApiServiceGigs()async{
     ShowAllGigs().showAllGIgs().then((value){
      log('inside provider');
      vendorGigs = value;
      notifyListeners();
      
    });


  }

}