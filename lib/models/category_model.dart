class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final int itemCount;
  final String? imageUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    this.itemCount = 0,
    this.imageUrl,
  });
}
