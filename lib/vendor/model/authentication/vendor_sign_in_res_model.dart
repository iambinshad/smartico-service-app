class VendorSignInResModel {
    VendorSignInResModel({
        required this.token,
        required this.data,
    });

    String? token;
    Data? data;

    factory VendorSignInResModel.fromJson(Map<String, dynamic> json) => VendorSignInResModel(
        token: json["token"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "data": data!.toJson(),
    };
}
class Data {
    Data({
        required this.user,
    });

    User user;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}

class User {
    User({
        required this.id,
    });

    String id;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
    };
}
