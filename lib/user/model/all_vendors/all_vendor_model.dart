
class AllVendorsModel {
    AllVendorsModel({
         this.id,
         this.fullName,
         this.userName,
         this.email,
        this.dob,
         this.gender,
         this.phone,
         this.status,
         this.profilePhoto,
    });

    String? id;
    String? fullName;
    String? userName;
    String? email;
    dynamic dob;
    String? gender;
    int? phone;
    String? profilePhoto;
    String? status;

    factory AllVendorsModel.fromJson(Map<String, dynamic> json) => AllVendorsModel(
        id: json["_id"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        dob: json["dob"],
        profilePhoto: json["profilePhoto"],
        gender: json["gender"],
        phone: json["phone"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
      
        "_id": id,
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "dob": dob,
        "profilePhoto":profilePhoto,
        "gender": gender,
        "phone": phone,
        "status": status,
    };
}
