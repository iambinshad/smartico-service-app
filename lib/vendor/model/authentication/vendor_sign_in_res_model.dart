class VendorSignInResModel {
    VendorSignInResModel({
        required this.token,
    });

    String? token;

    factory VendorSignInResModel.fromJson(Map<String, dynamic> json) => VendorSignInResModel(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
