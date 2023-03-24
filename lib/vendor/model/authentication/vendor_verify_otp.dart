class VendorOtpVerifyModel {
    VendorOtpVerifyModel({
        required this.otp,
    });

    int otp;

    factory VendorOtpVerifyModel.fromJson(Map<String, dynamic> json) => VendorOtpVerifyModel(
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "otp": otp,
    };
}
