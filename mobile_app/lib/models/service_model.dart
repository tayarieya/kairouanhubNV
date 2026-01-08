class ServiceModel {
  final int id;
  final String name;
  final String categoryName;
  final String? summary;
  final String? imageUrl;
  final String? rating;
  final String? location;
  final String? price;

  ServiceModel({
    required this.id,
    required this.name,
    required this.categoryName,
    this.summary,
    this.imageUrl,
    this.rating,
    this.location,
    this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    // The API might return 'category' as an object or null
    final category = json['category'];
    final categoryName = category != null ? category['name'] ?? 'General' : 'General';
    
    return ServiceModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown Service',
      categoryName: categoryName,
      summary: json['summary'],
      imageUrl: json['image_url'] ?? (category != null ? category['icon_url'] : null),
      rating: json['rating']?.toString() ?? '5.0',
      location: json['location'] ?? 'Kairouan',
      price: json['price'] ?? 'Starting 10 TND',
    );
  }
}
