
class AllBooking {
    AllBooking({
        required this.id,
        required this.userId,
        required this.title,
        required this.requirements,
        required this.vendorId,
        required this.gigId,
        required this.status,
        required this.date,
    });

    String id;
    String userId;
    String title;
    String requirements;
    String vendorId;
    String gigId;
    String status;
    DateTime date;

    factory AllBooking.fromJson(Map<String, dynamic> json) => AllBooking(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        requirements: json["requirements"],
        vendorId: json["vendorId"],
        gigId: json["gigId"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "requirements": requirements,
        "vendorId": vendorId,
        "gigId": gigId,
        "status": status,
        "date": date.toIso8601String(),
    };
}
