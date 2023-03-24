class VendorSignInReqModel {
    VendorSignInReqModel({
        required this.email,
        required this.password,
    });

    String email;
    String password;

    factory VendorSignInReqModel.fromJson(Map<String, dynamic> json) => VendorSignInReqModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}