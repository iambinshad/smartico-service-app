import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartico/user/controller/book_gig/booked_gigs.dart';
import 'package:smartico/user/controller/review_gig/fetch_gig_review.dart';
import 'package:smartico/user/controller/review_gig/rate_review_gig.dart';
import 'package:smartico/user/model/booking/booked_gigs_model.dart';
import 'package:smartico/user/model/booking/reveiw/add_reveiw_model.dart';
import 'package:smartico/user/model/booking/reveiw/get_gig_reveiw.dart';

class ReservedGigs with ChangeNotifier {
  List<BookedGigsModel?>? reservedGigs;
double rating = 3.0;
List<GIgReveiwModel?>? reveiws;
TextEditingController reviewController = TextEditingController();
TextEditingController reviewTitleController = TextEditingController();

  Future<void> getReservedGigs(BuildContext context) async {
    ReservedGigsService().fetchBookedGigs()!.then((value) {
      reservedGigs = value;
    });
    notifyListeners();
  }

  Future<void>postRating(ReviewAddingModel reveiwData)async{
    AddReveiwService().addReveiw(reveiwData);
  }
  Future<void>getreveiws(gigId)async{
    ReveiwService().listReveiw(gigId).then((value){
      reveiws = value;
      log(reveiws.toString());

    });
  }
  

   set setRating(ratingValue){
    rating = ratingValue;
    notifyListeners();
  }
}
