class ShowSingleGigDetailsModel {
    ShowSingleGigDetailsModel({
        required this.id,
        required this.title,
        required this.overview,
        required this.description,
        required this.price,
        required this.vendorId,
        required this.category,
        required this.image,
        required this.type,
        required this.date,
        required this.v,
    });

    String id;
    String title;
    String overview;
    String description;
    int price;
    VendorId vendorId;
    String category;
    String image;
    String type;
    DateTime date;
    int v;

    factory ShowSingleGigDetailsModel.fromJson(Map<String, dynamic> json) => ShowSingleGigDetailsModel(
        id: json["_id"],
        title: json["title"],
        overview: json["overview"],
        description: json["description"],
        price: json["price"],
        vendorId: VendorId.fromJson(json["vendorId"]),
        category: json["category"],
        image: json["image"],
        type: json["type"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "overview": overview,
        "description": description,
        "price": price,
        "vendorId": vendorId.toJson(),
        "category": category,
        "image": image,
        "type": type,
        "date": date.toIso8601String(),
        "__v": v,
    };
}

class VendorId {
    VendorId({
        required this.id,
        required this.fullName,
        required this.userName,
        required this.email,
        this.dob,
        required this.gender,
        required this.phone,
        required this.status,
        required this.date,
        required this.v,
    });

    String id;
    String fullName;
    String userName;
    String email;
    dynamic dob;
    String gender;
    int phone;
    String status;
    DateTime date;
    int v;

    factory VendorId.fromJson(Map<String, dynamic> json) => VendorId(
        id: json["_id"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        dob: json["dob"],
        gender: json["gender"],
        phone: json["phone"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "dob": dob,
        "gender": gender,
        "phone": phone,
        "status": status,
        "date": date.toIso8601String(),
        "__v": v,
    };
}
