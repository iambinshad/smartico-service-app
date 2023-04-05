class GigResModel {
    GigResModel({
        required this.status,
        required this.data,
    });

    String status;
    Data data;

    factory GigResModel.fromJson(Map<String, dynamic> json) => GigResModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.viewGig,
    });

    List<ViewGig> viewGig;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        viewGig: List<ViewGig>.from(json["viewGig"].map((x) => ViewGig.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "viewGig": List<dynamic>.from(viewGig.map((x) => x.toJson())),
    };
}

class ViewGig {
    ViewGig({
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
    Category category;
    String image;
    String type;
    DateTime date;
    int v;

    factory ViewGig.fromJson(Map<String, dynamic> json) => ViewGig(
        id: json["_id"],
        title: json["title"],
        overview: json["overview"],
        description: json["description"],
        price: json["price"],
        vendorId: json["vendorId"],
        category: Category.fromJson(json["category"]),
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
        "category": category.toJson(),
        "image": image,
        "type": type,
        "date": date.toIso8601String(),
        "__v": v,
    };
}

class Category {
    Category({
        required this.id,
        required this.name,
        required this.date,
        required this.v,
    });

    String id;
    String name;
    DateTime date;
    int v;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "date": date.toIso8601String(),
        "__v": v,
    };
}