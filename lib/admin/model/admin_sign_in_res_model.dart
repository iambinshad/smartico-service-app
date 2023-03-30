class AdminSignUpResModel {
    AdminSignUpResModel({
        required this.token,
    });

    String token;

    factory AdminSignUpResModel.fromJson(Map<String, dynamic> json) => AdminSignUpResModel(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
