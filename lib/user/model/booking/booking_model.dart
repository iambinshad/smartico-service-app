
class GigBookingModel {
    GigBookingModel({
        required this.vendorId,
        required this.title,
        required this.requirements,
        required this.gigId,
    });

    String vendorId;
    String title;
    String requirements;
    String gigId;

    factory GigBookingModel.fromJson(Map<String, dynamic> json) => GigBookingModel(
        vendorId: json["vendorId"],
        title: json["title"],
        requirements: json["requirements"],
        gigId: json["gigId"],
    );

    Map<String, dynamic> toJson() => {
        "vendorId": vendorId,
        "title": title,
        "requirements": requirements,
        "gigId": gigId,
    };
}
