import 'package:flutter/material.dart';
import 'package:smartico/user/controller/book_gig/booked_gigs.dart';
import 'package:smartico/user/model/booking/booked_gigs_model.dart';

class ReservedGigs with ChangeNotifier {
  List<BookedGigsModel?>? reservedGigs;
  // Future<List<BookedGigsModel>>? reservedGigs;

  Future<void> getReservedGigs(BuildContext context) async {
    ReservedGigsService().fetchBookedGigs()!.then((value) {
      reservedGigs = value;
    });
    notifyListeners();
  }
}
