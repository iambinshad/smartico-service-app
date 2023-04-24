
class ReviewAddingModel {
    ReviewAddingModel({
        required this.reviewData,
    });

    ReviewData reviewData;

    factory ReviewAddingModel.fromJson(Map<String, dynamic> json) => ReviewAddingModel(
        reviewData: ReviewData.fromJson(json["reviewData"]),
    );

    Map<String, dynamic> toJson() => {
        "reviewData": reviewData.toJson(),
    };
}

class ReviewData {
    ReviewData({
        required this.gig,
        required this.rating,
        required this.title,
        required this.description,
    });

    String gig;
    String rating;
    String title;
    String description;

    factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        gig: json["gig"],
        rating: json["rating"],
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "gig": gig,
        "rating": rating,
        "title": title,
        "description": description,
    };
}
