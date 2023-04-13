import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/user/controller/fetch_gigs/show_all_gig_service.dart';
import 'package:smartico/user/model/show_all_gigs/gig_model.dart';

class RecentServicesProvider with ChangeNotifier {
  List<ShowAllGigsToUserModle>? allGigs = [];
  List<ShowAllGigsToUserModle>? showList = [];
  Future<void> fetchAllGigs(context) async {
    ShowAllGigsService().showAllGigs().then((value) {
      allGigs = value;
      Provider.of<CommonProvider>(context, listen: false)
          .setShimmerLoading(false);

      notifyListeners();
    
    });
  }

  void filterGigList(String enteredText){
    List<ShowAllGigsToUserModle>? filteredList = [];
    if(enteredText.isEmpty){
      filteredList = allGigs;
    }else{
      filteredList = allGigs!.where((element) => element.title.toLowerCase().contains(enteredText.toLowerCase())).toList();
    }
    showList =filteredList;
    notifyListeners();
  }
}
