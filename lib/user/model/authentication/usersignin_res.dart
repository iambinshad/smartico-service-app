class UserSignInResModel {
    UserSignInResModel({
        required this.token,
    });

    String? token;

    factory UserSignInResModel.fromJson(Map<String, dynamic> json) => UserSignInResModel(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}

class UserIdModel {
    UserIdModel({
        required this.id,
    });

    String id;

    factory UserIdModel.fromJson(Map<String, dynamic> json) => UserIdModel(
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
    };
}
