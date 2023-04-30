class VendorProfileModel {
    Address? address;
    String? id;
    String? fullName;
    String? userName;
    String? email;
    dynamic dob;
    String? gender;
    int? phone;
    String? status;
    DateTime? date;
    String? about;
    String? github;
    String? googleDrive;
    String? linkedIn;
    String? profilePhoto;
    String? skill;

    VendorProfileModel({
        this.address,
        this.id,
        this.fullName,
        this.userName,
        this.email,
        this.dob,
        this.gender,
        this.phone,
        this.status,
        this.date,
        this.about,
        this.github,
        this.googleDrive,
        this.linkedIn,
        this.profilePhoto,
        this.skill,
    });

    factory VendorProfileModel.fromJson(Map<String, dynamic> json) => VendorProfileModel(
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        id: json["_id"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        dob: json["dob"],
        gender: json["gender"],
        phone: json["phone"],
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        about: json["about"],
        github: json["github"],
        googleDrive: json["googleDrive"],
        linkedIn: json["linkedIn"],
        profilePhoto: json["profilePhoto"],
        skill: json["skill"],
    );

    Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "_id": id,
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "dob": dob,
        "gender": gender,
        "phone": phone,
        "status": status,
        "date": date?.toIso8601String(),
        "about": about,
        "github": github,
        "googleDrive": googleDrive,
        "linkedIn": linkedIn,
        "profilePhoto": profilePhoto,
        "skill": skill,
    };
}

class Address {
    String? city;
    String? country;
    String? currentAddress;
    int? pincode;
    String? state;

    Address({
        this.city,
        this.country,
        this.currentAddress,
        this.pincode,
        this.state,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        country: json["country"],
        currentAddress: json["currentAddress"],
        pincode: json["pincode"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "currentAddress": currentAddress,
        "pincode": pincode,
        "state": state,
    };
}