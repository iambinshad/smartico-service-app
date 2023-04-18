class CancelBookingModel {
    CancelBookingModel({
        required this.orderId,
    });

    String orderId;

    factory CancelBookingModel.fromJson(Map<String, dynamic> json) => CancelBookingModel(
        orderId: json["orderId"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
    };
}

class CompleteBookingModel {
    CompleteBookingModel({
        required this.orderId,
    });

    String orderId;

    factory CompleteBookingModel.fromJson(Map<String, dynamic> json) => CompleteBookingModel(
        orderId: json["orderId"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
    };
}

class CancelUserBookingsModel {
    CancelUserBookingsModel({
        required this.orderId,
    });

    String orderId;

    factory CancelUserBookingsModel.fromJson(Map<String, dynamic> json) => CancelUserBookingsModel(
        orderId: json["orderId"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
    };
}
