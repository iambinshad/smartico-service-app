
class UserChatListModel {
    List<SortedUser>? sortedUsers;
    List<ConnectionCount>? connectionCount;

    UserChatListModel({
        this.sortedUsers,
        this.connectionCount,
    });

    factory UserChatListModel.fromJson(Map<String, dynamic> json) => UserChatListModel(
        sortedUsers: json["sortedUsers"] == null ? [] : List<SortedUser>.from(json["sortedUsers"]!.map((x) => SortedUser.fromJson(x))),
        connectionCount: json["connectionCount"] == null ? [] : List<ConnectionCount>.from(json["connectionCount"]!.map((x) => ConnectionCount.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sortedUsers": sortedUsers == null ? [] : List<dynamic>.from(sortedUsers!.map((x) => x.toJson())),
        "connectionCount": connectionCount == null ? [] : List<dynamic>.from(connectionCount!.map((x) => x.toJson())),
    };
}

class ConnectionCount {
    String? userId;
    int? count;

    ConnectionCount({
        this.userId,
        this.count,
    });

    factory ConnectionCount.fromJson(Map<String, dynamic> json) => ConnectionCount(
        userId: json["userId"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "count": count,
    };
}

class SortedUser {
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
    int? v;
    dynamic about;
    String? github;
    String? googleDrive;
    String? linkedIn;
    String? profilePhoto;
    String? skill;
    String? upiId;

    SortedUser({
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
        this.v,
        this.about,
        this.github,
        this.googleDrive,
        this.linkedIn,
        this.profilePhoto,
        this.skill,
        this.upiId,
    });

    factory SortedUser.fromJson(Map<String, dynamic> json) => SortedUser(
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
        v: json["__v"],
        about: json["about"],
        github: json["github"],
        googleDrive: json["googleDrive"],
        linkedIn: json["linkedIn"],
        profilePhoto: json["profilePhoto"],
        skill: json["skill"],
        upiId: json["upiId"],
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
        "__v": v,
        "about": about,
        "github": github,
        "googleDrive": googleDrive,
        "linkedIn": linkedIn,
        "profilePhoto": profilePhoto,
        "skill": skill,
        "upiId": upiId,
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
