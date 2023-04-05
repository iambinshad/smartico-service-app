class CategoryResModel {
  final String id;
  final String name;

  CategoryResModel({required this.id, required this.name});

  factory CategoryResModel.fromJson(Map<String, dynamic> json) {
    return CategoryResModel(
      id: json['_id'],
      name: json['name'],
    ); 
  }

}
