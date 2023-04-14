import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/user/controller/book_gig/booked_gigs.dart';
import 'package:smartico/user/model/booking/booked_gigs_model.dart';

class ReservedGigs with ChangeNotifier {
  // Future<BookedGigsModel?>? reservedGigs;
  List<BookedGigsModel>? reservedGigs;


  Future<void> getreservedGigs(BuildContext context) async {
     ReservedGigsService().fetchBookedGigs().then((value){
      reservedGigs = value;

     });
     notifyListeners();
    
  }
}
