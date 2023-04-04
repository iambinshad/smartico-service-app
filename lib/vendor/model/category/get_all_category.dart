class CatogoryResModel {
    CatogoryResModel({
        required this.data,
    });

    Data data;

    factory CatogoryResModel.fromJson(Map<String, dynamic> json) => CatogoryResModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.newCategory,
    });

    NewCategory newCategory;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        newCategory: NewCategory.fromJson(json["newCategory"]),
    );

    Map<String, dynamic> toJson() => {
        "newCategory": newCategory.toJson(),
    };
}

class NewCategory {
    NewCategory({
        required this.name,
        required this.id,
    });

    String name;
    String id;

    factory NewCategory.fromJson(Map<String, dynamic> json) => NewCategory(
        name: json["name"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
    };
}
