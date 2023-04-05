class VendorIdModle {
    VendorIdModle({
        required this.vendorId,
    });

    String? vendorId;

    factory VendorIdModle.fromJson(Map<String, dynamic> json) => VendorIdModle(
        vendorId: json["vendorId"],
    );

    Map<String, dynamic> toJson() => {
        "vendorId": vendorId,
    };
}
