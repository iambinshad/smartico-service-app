import 'package:flutter/material.dart';
import 'package:smartico/user/controller/book_gig/booking_service.dart';
import 'package:smartico/user/model/booking/booking_model.dart';

class BookGigPrvider with ChangeNotifier {
  String? vendorId;
  String? title;
  String? gigId;

  final bookingRequirements = TextEditingController();

  Future<void> booking(GigBookingModel bookingModel, context) async {
    await BookingService().bookingapiService(bookingModel, context);
  }
}
