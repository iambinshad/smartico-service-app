
import 'package:flutter/material.dart';
import 'package:smartico/user/model/booking/cancel_booking.dart';
import 'package:smartico/vendor/controller/bookings/booking_service.dart';
import 'package:smartico/vendor/model/booking/new_bookings_model.dart';

class AllBookingProvider with ChangeNotifier {
  List<AllOrders>? allBookings = [];

  Future<void> fetchAllBookings(context) async {
    ShowAllBookingService().showAllBookings().then((value) {
      allBookings = value;
      notifyListeners();
    });
  }

  Future<void> completeService(context, orderId) async {
    ShowAllBookingService()
        .completeService(context, CompleteBookingModel(orderId: orderId));
        notifyListeners();
  }
}
