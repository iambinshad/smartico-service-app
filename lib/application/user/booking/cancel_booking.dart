import 'package:flutter/cupertino.dart';
import 'package:smartico/user/controller/book_gig/cancel_booking.dart';
import 'package:smartico/user/model/booking/cancel_booking.dart';


class CancelBookingprovider with ChangeNotifier{

  Future<void>cancelBooking(context,gigId)async{

    final orderId = CancelBookingModel(orderId: gigId);
    await CancelBookingService().cancelBooking(context, orderId);
    notifyListeners();
  }



}