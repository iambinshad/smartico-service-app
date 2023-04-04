
class CompleteSignUpModel {
    CompleteSignUpModel({
        required this.skill,
        required this.googleDrive,
        required this.linkedIn,
        required this.github,
        required this.address,
         this.upiId,
        required this.about,
        required this.profilePhoto,
         this.status,
         this.date,
    });

    String skill;
    String googleDrive;
    String linkedIn;
    String github;
    Address address;
    String? upiId;
    String about;
    String profilePhoto;
    String? status;
    String? date;

    factory CompleteSignUpModel.fromJson(Map<String, dynamic> json) => CompleteSignUpModel(
        skill: json["skill"],
        googleDrive: json["googleDrive"],
        linkedIn: json["linkedIn"],
        github: json["github"],
        address: Address.fromJson(json["address"]),
        upiId: json["upiId"],
        about: json["about"],
        profilePhoto: json["profilePhoto"],
        status: json["status"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "skill": skill,
        "googleDrive": googleDrive,
        "linkedIn": linkedIn,
        "github": github,
        "address": address.toJson(),
        "upiId": upiId,
        "about": about,
        "profilePhoto": profilePhoto,
        "status": status,
        "date": date,
    };
}

class Address {
    Address({
        required this.pincode,
        required this.country,
        required this.currentAddress,
        required this.city,
        required this.state,
    });

    String pincode;
    String country;
    String currentAddress;
    String city;
    String state;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        pincode: json["pincode"],
        country: json["country"],
        currentAddress: json["currentAddress"],
        city: json["city"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "pincode": pincode,
        "country": country,
        "currentAddress": currentAddress,
        "city": city,
        "state": state,
    };
}
