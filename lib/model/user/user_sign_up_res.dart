class UserSignUpResModel {
    UserSignUpResModel({
        required this.token,
    });

    String token;

    factory UserSignUpResModel.fromJson(Map<String, dynamic> json) => UserSignUpResModel(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
