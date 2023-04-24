
class VendorApprovelModel {
    VendorApprovelModel({
        required this.id,
    });

    String id;

    factory VendorApprovelModel.fromJson(Map<String, dynamic> json) => VendorApprovelModel(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}


class VendorBlockModel {
    VendorBlockModel({
        required this.id,
    });

    String id;

    factory VendorBlockModel.fromJson(Map<String, dynamic> json) => VendorBlockModel(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
