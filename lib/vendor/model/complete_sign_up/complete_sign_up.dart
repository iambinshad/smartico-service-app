class CompleteSignUpModel {
  String fullName;
  String? userName;
  String email;
  String? skill;
  String? googleDrive;
  String? linkedIn;
  String? github;
  Address address;
  String? upiId;
  String about;
  String profilePhoto;
  String? dob;
  String? gender;
  String phone;

  CompleteSignUpModel({
   required this.fullName,
    this.userName,
   required this.email,
    this.skill,
    this.googleDrive,
    this.linkedIn,
    this.github,
   required this.address,
    this.upiId,
   required this.about,
   required this.profilePhoto,
    this.dob,
    this.gender,
   required this.phone,
  });

  factory CompleteSignUpModel.fromJson(Map<String, dynamic> json) {
    return CompleteSignUpModel(
      fullName: json['fullName'],
      userName: json['userName'],
      email: json['email'],
      skill: json['skill'],
      googleDrive: json['googleDrive'],
      linkedIn: json['linkedIn'],
      github: json['github'],
      address: Address.fromJson(json['address']),
      upiId: json['upiId'],
      about: json['about'],
      profilePhoto: json['profilePhoto'],
      dob: json['dob'],
      gender: json['gender'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'userName': userName,
        'email': email,
        'skill': skill,
        'googleDrive': googleDrive,
        'linkedIn': linkedIn,
        'github': github,
        'address': address.toJson(),
        'upiId': upiId,
        'about': about,
        'profilePhoto': profilePhoto,
        'dob': dob,
        'gender': gender,
        'phone': phone,
      };
}

class Address {
  String? pincode;
  String country;
  String currentAddress;
  String city;
  String state;

  Address({
    this.pincode,
   required this.country,
   required this.currentAddress,
   required this.city,
   required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      pincode: json['pincode'],
      country: json['country'],
      currentAddress: json['currentAddress'],
      city: json['city'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() => {
        'pincode': pincode,
        'country': country,
        'currentAddress': currentAddress,
        'city': city,
        'state': state,
      };
}
