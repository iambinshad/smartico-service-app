class VendorSignUpResModel {
    VendorSignUpResModel({
        required this.token,
    });

    String token;

    factory VendorSignUpResModel.fromJson(Map<String, dynamic> json) => VendorSignUpResModel(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
