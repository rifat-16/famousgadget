import 'package:get/get.dart';
import '../data/mock_database.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class HomeController extends GetxController {
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final RxList<ProductModel> bestSellers = <ProductModel>[].obs;
  final RxList<ProductModel> hotDeals = <ProductModel>[].obs;
  final RxList<ProductModel> recommendedProducts = <ProductModel>[].obs;
  final RxInt activeBannerIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    categories.assignAll(MockDatabase.categories);
    featuredProducts.assignAll(MockDatabase.featuredProducts);
    bestSellers.assignAll(MockDatabase.bestSellers);
    hotDeals.assignAll(MockDatabase.hotDeals);
    recommendedProducts.assignAll(MockDatabase.recommendedProducts);
  }
}
