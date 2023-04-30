
class UserProfileEditModel {
    String? userName;
    String? dob;
    String? gender;
    String? phone;
    String? location;
    String? profilePhoto;

    UserProfileEditModel({
        this.userName,
        this.dob,
        this.gender,
        this.phone,
        this.location,
        this.profilePhoto,
    });

    factory UserProfileEditModel.fromJson(Map<String, dynamic> json) => UserProfileEditModel(
        userName: json["userName"],
        dob: json["dob"],
        gender: json["gender"],
        phone: json["phone"],
        location: json["location"],
        profilePhoto: json["profilePhoto"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "dob": dob,
        "gender": gender,
        "phone": phone,
        "location": location,
        "profilePhoto": profilePhoto,
    };
}
