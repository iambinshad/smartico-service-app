class AdminSignInReqModel {
    AdminSignInReqModel({
        required this.email,
        required this.password,
    });

    String email;
    String password;

    factory AdminSignInReqModel.fromJson(Map<String, dynamic> json) => AdminSignInReqModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}