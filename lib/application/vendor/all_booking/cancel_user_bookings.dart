import 'package:flutter/material.dart';
import 'package:smartico/user/model/booking/cancel_booking.dart';
import 'package:smartico/vendor/controller/bookings/cancel_user_bookings.dart';

class CancelUserBookingsProvider with ChangeNotifier{

Future<void>cancelUserBooking(context,gigId)async{
  final orderId = CancelUserBookingsModel(orderId: gigId);
  await CancelUserBookingsService().cancelUserBooking(context,orderId);

}
}