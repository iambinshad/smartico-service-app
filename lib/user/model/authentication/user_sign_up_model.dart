class UserSignUpModel {
    UserSignUpModel({
        required this.fullName,
        required this.userName,
        required this.email,
        required this.phone,
        required this.password,
        required this.passwordConfirm,
    });

    String fullName;
    String userName;
    String email;
    String phone;
    String password;
    String passwordConfirm;

    factory UserSignUpModel.fromJson(Map<String, dynamic> json) => UserSignUpModel(
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        passwordConfirm: json["passwordConfirm"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "phone": phone,
        "password": password,
        "passwordConfirm": passwordConfirm,
    };
}
