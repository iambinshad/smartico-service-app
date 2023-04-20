
class AllVendorsByAdmin {
    AllVendorsByAdmin({
        //  this.address,
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

    // Address? address;
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

    factory AllVendorsByAdmin.fromJson(Map<String, dynamic> json) => AllVendorsByAdmin(
        // address: Address?.fromJson(json["address"]),
        id: json["_id"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        dob: json["dob"],
        gender: json["gender"],
        phone: json["phone"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
        about: json["about"],
        github: json["github"],
        googleDrive: json["googleDrive"],
        linkedIn: json["linkedIn"],
        profilePhoto: json["profilePhoto"],
        skill: json["skill"],
    );

    Map<String, dynamic> toJson() => {
        // "address": address?.toJson(),
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
    Address({
        required this.city,
        required this.country,
        required this.currentAddress,
        required this.pincode,
        required this.state,
    });

    String city;
    String country;
    String currentAddress;
    int pincode;
    String state;

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
