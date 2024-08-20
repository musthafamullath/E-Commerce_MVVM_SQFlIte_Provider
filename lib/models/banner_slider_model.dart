class BannerSliderModel {
  final String title;
  final String imageUrl;

  BannerSliderModel({required this.title, required this.imageUrl});

  factory BannerSliderModel.fromJson(Map<String, dynamic> json) {
    return BannerSliderModel(
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image_url': imageUrl,
    };
  }
}
