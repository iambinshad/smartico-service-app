class VendorSignUpModel {
    VendorSignUpModel({
        required this.fullName,
        required this.userName,
        required this.email,
        required this.phone,
        required this.gender,
        required this.dob,
        required this.password,
        required this.passwordConfirm,
    });

    String fullName;
    String userName;
    String email;
    String phone;
    String gender;
    String dob;
    String password;
    String passwordConfirm;

    factory VendorSignUpModel.fromJson(Map<String, dynamic> json) => VendorSignUpModel(
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        dob: json["dob"],
        password: json["password"],
        passwordConfirm: json["passwordConfirm"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "phone": phone,
        "gender": gender,
        "dob": dob,
        "password": password,
        "passwordConfirm": passwordConfirm,
    };
}
