
class NewGigCreateModel {
    NewGigCreateModel({
        required this.title,
        required this.overview,
        required this.image,
        required this.type,
        required this.description,
        required this.price,
        required this.category,
        required this.vendorId,
    });

    String title;
    String overview;
    String image;
    String type;
    String description;
    String price;
    String category;
    String vendorId;

    factory NewGigCreateModel.fromJson(Map<String, dynamic> json) => NewGigCreateModel(
        title: json["title"],
        overview: json["overview"],
        image: json["image"],
        type: json["type"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        vendorId: json["vendorId"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "overview": overview,
        "image": image,
        "type": type,
        "description": description,
        "price": price,
        "category": category,
        "vendorId": vendorId,
    };
}
