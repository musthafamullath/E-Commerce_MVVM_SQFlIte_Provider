class CategoriesModel {
  final String title;
  final String imageUrl;

  CategoriesModel({required this.title, required this.imageUrl});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image_url': imageUrl,
    };
  }
}
