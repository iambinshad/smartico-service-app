
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
// class AllOrders {
//     String? id;
//     UserId? userId;
//     String? title;
//     String? requirements;
//     String? vendorId;
//     GigId? gigId;
//     String? status;
//     DateTime? date;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     int? v;

//     AllOrders({
//         this.id,
//         this.userId,
//         this.title,
//         this.requirements,
//         this.vendorId,
//         this.gigId,
//         this.status,
//         this.date,
//         this.createdAt,
//         this.updatedAt,
//         this.v,
//     });

//     factory AllOrders.fromJson(Map<String, dynamic> json) => AllOrders(
//         id: json["_id"],
//         userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
//         title: json["title"],
//         requirements: json["requirements"],
//         vendorId: json["vendorId"],
//         gigId: json["gigId"] == null ? null : GigId.fromJson(json["gigId"]),
//         status: json["status"],
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId?.toJson(),
//         "title": title,
//         "requirements": requirements,
//         "vendorId": vendorId,
//         "gigId": gigId?.toJson(),
//         "status": status,
//         "date": date?.toIso8601String(),
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//     };
// }

// class GigId {
//     String? id;
//     String? title;
//     String? overview;
//     String? description;
//     int? price;
//     String? vendorId;
//     String? category;
//     String? image;
//     String? type;
//     DateTime? date;
//     int? v;

//     GigId({
//         this.id,
//         this.title,
//         this.overview,
//         this.description,
//         this.price,
//         this.vendorId,
//         this.category,
//         this.image,
//         this.type,
//         this.date,
//         this.v,
//     });

//     factory GigId.fromJson(Map<String, dynamic> json) => GigId(
//         id: json["_id"],
//         title: json["title"],
//         overview: json["overview"],
//         description: json["description"],
//         price: json["price"],
//         vendorId: json["vendorId"],
//         category: json["category"],
//         image: json["image"],
//         type: json["type"],
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "title": title,
//         "overview": overview,
//         "description": description,
//         "price": price,
//         "vendorId": vendorId,
//         "category": category,
//         "image": image,
//         "type": type,
//         "date": date?.toIso8601String(),
//         "__v": v,
//     };
// }

// class UserId {
//     String? id;
//     String? fullName;
//     String? userName;
//     String? email;
//     int? phone;
//     String? status;
//     DateTime? date;
//     int? v;
//     dynamic dob;
//     dynamic gender;
//     dynamic location;
//     String? profilePhoto;

//     UserId({
//         this.id,
//         this.fullName,
//         this.userName,
//         this.email,
//         this.phone,
//         this.status,
//         this.date,
//         this.v,
//         this.dob,
//         this.gender,
//         this.location,
//         this.profilePhoto,
//     });

//     factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//         id: json["_id"],
//         fullName: json["fullName"],
//         userName: json["userName"],
//         email: json["email"],
//         phone: json["phone"],
//         status: json["status"],
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         v: json["__v"],
//         dob: json["dob"],
//         gender: json["gender"],
//         location: json["location"],
//         profilePhoto: json["profilePhoto"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "fullName": fullName,
//         "userName": userName,
//         "email": email,
//         "phone": phone,
//         "status": status,
//         "date": date?.toIso8601String(),
//         "__v": v,
//         "dob": dob,
//         "gender": gender,
//         "location": location,
//         "profilePhoto": profilePhoto,
//     };
// }
class AllOrders {
    String? id;
    UserId? userId;
    String? title;
    String? requirements;
    String? vendorId;
    GigId? gigId;
    String? status;
    DateTime? date;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    AllOrders({
        this.id,
        this.userId,
        this.title,
        this.requirements,
        this.vendorId,
        this.gigId,
        this.status,
        this.date,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory AllOrders.fromJson(Map<String, dynamic> json) => AllOrders(
        id: json["_id"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        title: json["title"],
        requirements: json["requirements"],
        vendorId: json["vendorId"],
        gigId: json["gigId"] == null ? null : GigId.fromJson(json["gigId"]),
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
        "title": title,
        "requirements": requirements,
        "vendorId": vendorId,
        "gigId": gigId?.toJson(),
        "status": status,
        "date": date?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class GigId {
    String? id;
    String? title;
    String? overview;
    String? description;
    int? price;
    String? vendorId;
    String? category;
    String? image;
    String? type;
    DateTime? date;
    int? v;

    GigId({
        this.id,
        this.title,
        this.overview,
        this.description,
        this.price,
        this.vendorId,
        this.category,
        this.image,
        this.type,
        this.date,
        this.v,
    });

    factory GigId.fromJson(Map<String, dynamic> json) => GigId(
        id: json["_id"],
        title: json["title"],
        overview: json["overview"],
        description: json["description"],
        price: json["price"],
        vendorId: json["vendorId"],
        category: json["category"],
        image: json["image"],
        type: json["type"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "overview": overview,
        "description": description,
        "price": price,
        "vendorId": vendorId,
        "category": category,
        "image": image,
        "type": type,
        "date": date?.toIso8601String(),
        "__v": v,
    };
}

class UserId {
    String? id;
    String? fullName;
    String? userName;
    String? email;
    int? phone;
    String? status;
    DateTime? date;
    int? v;
    dynamic dob;
    dynamic gender;
    dynamic location;
    String? profilePhoto;

    UserId({
        this.id,
        this.fullName,
        this.userName,
        this.email,
        this.phone,
        this.status,
        this.date,
        this.v,
        this.dob,
        this.gender,
        this.location,
        this.profilePhoto,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        phone: json["phone"],
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
        dob: json["dob"],
        gender: json["gender"],
        location: json["location"],
        profilePhoto: json["profilePhoto"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "phone": phone,
        "status": status,
        "date": date?.toIso8601String(),
        "__v": v,
        "dob": dob,
        "gender": gender,
        "location": location,
        "profilePhoto": profilePhoto,
    };
}
