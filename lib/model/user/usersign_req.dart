class UserSignInReqModel {
    UserSignInReqModel({
        required this.email,
        required this.password,
    });

    String email;
    String password;

    factory UserSignInReqModel.fromJson(Map<String, dynamic> json) => UserSignInReqModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}