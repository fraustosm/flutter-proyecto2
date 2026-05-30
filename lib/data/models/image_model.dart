class ImageModel {
  final String id;
  final String imageUrl;
  final String description;
  final String author;

  const ImageModel({
    required this.id,
    required this.imageUrl,
    required this.description,
    required this.author,
  });

  factory ImageModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ImageModel(
      id: json['id'] ?? '',
      imageUrl: json['urls']?['regular'] ?? '',
      description:
          json['alt_description'] ??
          'No description',
      author:
          json['user']?['name'] ??
          'Unknown',
    );
  }
}