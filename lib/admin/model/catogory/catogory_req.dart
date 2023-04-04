class CatogoryReqModel {
    CatogoryReqModel({
        required this.name,
    });

    String name;

    factory CatogoryReqModel.fromJson(Map<String, dynamic> json) => CatogoryReqModel(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
