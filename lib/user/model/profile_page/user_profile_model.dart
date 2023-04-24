
class UserProfileModel {
    UserProfileModel({
        required this.id,
        required this.fullName,
        required this.userName,
        required this.email,
        required this.phone,
        required this.status,
    });

    String id;
    String fullName;
    String userName;
    String email;
    int phone;
    String status;

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        id: json["_id"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        phone: json["phone"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "phone": phone,
        "status": status,
    };
}
