class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final int itemCount;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    this.itemCount = 0,
  });
}
