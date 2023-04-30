
class EditVendorProfileModel {
    String? userName;
    String? mobile;
    String? upiId;
    String? skill;
    String? dob;
    String? gender;
    String? googleDrive;
    String? linkedIn;
    String? github;
    String? about;
    String? profilePhoto;
    String? country;
    String? currentAddress;
    String? city;
    String? state;

    EditVendorProfileModel({
        this.userName,
        this.mobile,
        this.upiId,
        this.skill,
        this.dob,
        this.gender,
        this.googleDrive,
        this.linkedIn,
        this.github,
        this.about,
        this.profilePhoto,
        this.country,
        this.currentAddress,
        this.city,
        this.state,
    });

    factory EditVendorProfileModel.fromJson(Map<String, dynamic> json) => EditVendorProfileModel(
        userName: json["userName"],
        mobile: json["mobile"],
        upiId: json["upiId"],
        skill: json["skill"],
        dob: json["dob"],
        gender: json["gender"],
        googleDrive: json["googleDrive"],
        linkedIn: json["linkedIn"],
        github: json["github"],
        about: json["about"],
        profilePhoto: json["profilePhoto"],
        country: json["country"],
        currentAddress: json["currentAddress"],
        city: json["city"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "mobile": mobile,
        "upiId": upiId,
        "skill": skill,
        "dob": dob,
        "gender": gender,
        "googleDrive": googleDrive,
        "linkedIn": linkedIn,
        "github": github,
        "about": about,
        "profilePhoto": profilePhoto,
        "country": country,
        "currentAddress": currentAddress,
        "city": city,
        "state": state,
    };
}
