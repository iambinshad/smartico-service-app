class UserOtpVerifyModel {
    UserOtpVerifyModel({
        required this.otp,
    });

    int otp;

    factory UserOtpVerifyModel.fromJson(Map<String, dynamic> json) => UserOtpVerifyModel(
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "otp": otp,
    };
}
