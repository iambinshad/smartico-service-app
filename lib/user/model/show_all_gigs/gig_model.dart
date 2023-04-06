
class ShowAllGigsToUserModle {
    ShowAllGigsToUserModle({
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
        required this.v,
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
    int v;

    factory ShowAllGigsToUserModle.fromJson(Map<String, dynamic> json) => ShowAllGigsToUserModle(
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
        v: json["__v"],
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
        "__v": v,
    };
}
