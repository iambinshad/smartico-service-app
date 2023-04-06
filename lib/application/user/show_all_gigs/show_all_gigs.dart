import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartico/user/controller/fetch_gigs/show_all_gig_service.dart';
import 'package:smartico/user/model/show_all_gigs/gig_model.dart';

class RecentServicesProvider with ChangeNotifier{

  List<ShowAllGigsToUserModle>? AllGigs = [];

  Future<void>FetchAllGigs()async{
    ShowAllGigsService().showAllGigs().then((value){
      AllGigs = value;
      notifyListeners();
      log(AllGigs.toString(),name: 'allgigs');
    });
  }

}