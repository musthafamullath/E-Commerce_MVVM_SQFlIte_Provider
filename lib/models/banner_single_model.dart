class BannerSingleModel {
  final String imageUrl;
  final String title;

  BannerSingleModel({required this.imageUrl,required this.title});

  factory BannerSingleModel.fromJson(Map<String, dynamic> json) {
    return BannerSingleModel(
      title: json['title'],
      imageUrl: json['image_url'] ?? json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title':title,
      'image_url': imageUrl,
    };
  }
}

