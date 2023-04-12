
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/user/controller/fetch_gigs/get_single_gig.dart';
import 'package:smartico/user/model/show_all_gigs/show_single_gig.dart/show_single_gig_model.dart';

class SingleGigDetailsProvider with ChangeNotifier {
  Future<ShowSingleGigDetailsModel?>? gig;

  Future<void> getGig(gigId,context) async {
    Provider.of<CommonProvider>(context,listen: false).setShimmerLoading(true);
   gig= ShowSingleGigService().fetchGig(gigId,context);
  }

}
