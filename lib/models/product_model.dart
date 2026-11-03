class ProductModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewCount;
  final String category;
  final bool inStock;
  final int? savePercentage;
  final List<String> colors;
  final Map<String, String> specifications;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.rating = 4.8,
    this.reviewCount = 0,
    required this.category,
    this.inStock = true,
    this.savePercentage,
    this.colors = const [],
    this.specifications = const {},
  });

  String get formattedPrice => '৳${price.toStringAsFixed(0)}';
  String? get formattedOldPrice =>
      oldPrice != null ? '৳${oldPrice!.toStringAsFixed(0)}' : null;
}
