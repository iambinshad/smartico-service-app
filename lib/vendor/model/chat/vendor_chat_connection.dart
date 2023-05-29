
class VendorChatListModel {
  List<SortedVendor>? sortedUsers;
  List<ConnectionCountV> connectionCount;

  VendorChatListModel({
    required this.sortedUsers,
    required this.connectionCount,
  });

// factory VendorChatListModel.fromJson(Map<String, dynamic> json) {
//   if (json != null) {
//     return VendorChatListModel(
//       sortedUsers: json['sortedUsers'] != null
//           ? List<SortedVendor>.from(json['sortedUsers'].map((x) => SortedVendor.fromJson(x)))
//           : [],
//       connectionCount: json['connectionCount'] != null
//           ? List<ConnectionCountV>.from(json['connectionCount'].map((x) => ConnectionCountV.fromJson(x)))
//           : [],
//     );
//   } else {
//     // Handle the case where the JSON object is null
//     // Return a default or throw an exception, depending on your requirement
//     return VendorChatListModel(
//       sortedUsers: [],
//       connectionCount: [],
//     );
//   }
// }
  factory VendorChatListModel.fromJson(Map<String, dynamic> json) {
    return VendorChatListModel(
      sortedUsers: List<SortedVendor>.from(
          json['sortedUsers'].map((x) => SortedVendor.fromJson(x))),
      connectionCount: List<ConnectionCountV>.from(
          json['connectionCount'].map((x) => ConnectionCountV.fromJson(x))),
    );
  }
}

class ConnectionCountV {
  String userId;
  int count;

  ConnectionCountV({
    required this.userId,
    required this.count,
  });

  factory ConnectionCountV.fromJson(Map<String, dynamic> json) {
    return ConnectionCountV(
      userId: json['userId'],
      count: json['count'],
    );
  }
}

class SortedVendor {
  String id;
  String fullName;
  String userName;
  String email;
  int phone;
  String status;
  DateTime date;
  int v;
  dynamic dob;
  dynamic gender;
  dynamic location;
  String? profilePhoto;

  SortedVendor({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.phone,
    required this.status,
    required this.date,
    required this.v,
    required this.dob,
    required this.gender,
    required this.location,
    required this.profilePhoto,
  });

  factory SortedVendor.fromJson(Map<String, dynamic> json) {
    return SortedVendor(
      id: json['_id'],
      fullName: json['fullName'],
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      v: json['__v'],
      dob: json['dob'],
      gender: json['gender'],
      location: json['location'],
      profilePhoto: json['profilePhoto'],
    );
  }
}