class GIgReveiwModel {
    GIgReveiwModel({
        required this.id,
        required this.userId,
        required this.rating,
        required this.title,
        required this.description,
        required this.date,
        required this.v,
    });

    String id;
    UserId userId;
    double rating;
    String title;
    String description;
    DateTime date;
    int v;

    factory GIgReveiwModel.fromJson(Map<String, dynamic> json) => GIgReveiwModel(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        rating: json["rating"]?.toDouble(),
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "rating": rating,
        "title": title,
        "description": description,
        "date": date.toIso8601String(),
        "__v": v,
    };
}

class UserId {
    UserId({
        required this.id,
        required this.fullName,
        required this.userName,
        required this.email,
        required this.phone,
        required this.status,
        required this.date,
    });

    String id;
    String fullName;
    String userName;
    String email;
    int phone;
    String status;
    DateTime date;

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        phone: json["phone"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "phone": phone,
        "status": status,
        "date": date.toIso8601String(),
    };
}
