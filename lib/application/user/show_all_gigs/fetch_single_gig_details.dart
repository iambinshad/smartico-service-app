import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartico/user/controller/fetch_gigs/get_single_gig.dart';
import 'package:smartico/user/model/show_all_gigs/show_single_gig.dart/show_single_gig_model.dart';

class SingleGigDetailsProvider with ChangeNotifier {
  Future<ShowSingleGigDetailsModel?>? gig;

  Future<void> getGig(gigId) async {
   gig= ShowSingleGigService().fetchGig(gigId);
  }

}
