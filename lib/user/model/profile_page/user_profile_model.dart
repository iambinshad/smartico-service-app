
// class UserProfileModel {
//     UserProfileModel({
//         required this.id,
//         required this.fullName,
//         required this.userName,
//         required this.email,
//         required this.phone,
//         required this.status,
//     });

//     String id;
//     String fullName;
//     String userName;
//     String email;
//     int phone;
//     String status;

//     factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
//         id: json["_id"],
//         fullName: json["fullName"],
//         userName: json["userName"],
//         email: json["email"],
//         phone: json["phone"],
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "fullName": fullName,
//         "userName": userName,
//         "email": email,
//         "phone": phone,
//         "status": status,
//     };
// }
class UserProfileModel {
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

    UserProfileModel({
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

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
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
