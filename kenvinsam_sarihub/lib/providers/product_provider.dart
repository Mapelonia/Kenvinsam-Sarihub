import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/models/product.dart';
import 'package:kenvinsam_sarihub/services/product_service.dart';

final productServiceProvider = Provider<ProductService>((ref) => ProductService());

final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.read(productServiceProvider);
  return service.getAllProducts();
});

final productsByCategoryProvider =
    FutureProvider.family<List<Product>, String>((ref, category) async {
  final service = ref.read(productServiceProvider);
  return service.getProductsByCategory(category);
});

final searchProductsProvider =
    FutureProvider.family<List<Product>, String>((ref, query) async {
  final service = ref.read(productServiceProvider);
  return service.searchProducts(query);
});

final recentProductsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.read(productServiceProvider);
  return service.getRecentlyUpdatedProducts();
});

final categoryCountsProvider = FutureProvider<Map<String, int>>((ref) async {
  final service = ref.read(productServiceProvider);
  return service.getCategoryProductCounts();
});

final totalProductCountProvider = FutureProvider<int>((ref) async {
  final service = ref.read(productServiceProvider);
  return service.getTotalProductCount();
});

// Refresh trigger
final productRefreshProvider = StateProvider<int>((ref) => 0);

void refreshProducts(dynamic ref) {
  ref.invalidate(allProductsProvider);
  ref.invalidate(recentProductsProvider);
  ref.invalidate(categoryCountsProvider);
  ref.invalidate(totalProductCountProvider);
}
