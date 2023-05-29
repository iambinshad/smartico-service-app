import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartico/user/controller/fetch_gigs/fetch_vendors_all_gigs.dart';
import 'package:smartico/user/model/show_all_gigs/vendor_all_gigs/personalised_gigs.dart';

class VendorAllGigsFetching with ChangeNotifier {
  List<PersonalisedGigsModel>? vendorAllGigs = [];
  void fetchVendorAllGigs(String vendorId) {
    FetchVendorAllGigs().fetch(vendorId).then((value) {
      vendorAllGigs = value;
      log(vendorAllGigs.toString(),name: "VendorAllGigs got data");
    });
  }
}
