class BookedGigsModel {
    BookedGigsModel({
        required this.id,
        required this.userId,
        required this.title,
        required this.requirements,
        required this.vendorId,
        required this.gigId,
        required this.status,
    });

    String id;
    String userId;
    String title;
    String requirements;
    String vendorId;
    GigId gigId;
    String status;

    factory BookedGigsModel.fromJson(Map<String, dynamic> json) => BookedGigsModel(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        requirements: json["requirements"],
        vendorId: json["vendorId"],
        gigId: GigId.fromJson(json["gigId"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "requirements": requirements,
        "vendorId": vendorId,
        "gigId": gigId.toJson(),
        "status": status,
    };
}

class GigId {
    GigId({
        required this.id,
        required this.title,
        required this.overview,
        required this.description,
        required this.price,
        required this.vendorId,
        required this.category,
        required this.image,
        required this.type,
        required this.date,
    });

    String id;
    String title;
    String overview;
    String description;
    int price;
    String vendorId;
    String category;
    String image;
    String type;
    DateTime date;

    factory GigId.fromJson(Map<String, dynamic> json) => GigId(
        id: json["_id"],
        title: json["title"],
        overview: json["overview"],
        description: json["description"],
        price: json["price"],
        vendorId: json["vendorId"],
        category: json["category"],
        image: json["image"],
        type: json["type"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "overview": overview,
        "description": description,
        "price": price,
        "vendorId": vendorId,
        "category": category,
        "image": image,
        "type": type,
        "date": date.toIso8601String(),
    };
}