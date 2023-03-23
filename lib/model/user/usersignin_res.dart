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
