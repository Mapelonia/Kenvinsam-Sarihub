import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/models/category.dart';
import 'package:kenvinsam_sarihub/services/category_service.dart';

final categoryServiceProvider = Provider<CategoryService>((ref) => CategoryService());

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final service = ref.read(categoryServiceProvider);
  return service.getAllCategories();
});

final categoryNamesProvider = FutureProvider<List<String>>((ref) async {
  final categories = await ref.watch(categoriesProvider.future);
  return categories.map((c) => c.name).toList();
});

void refreshCategories(dynamic ref) {
  ref.invalidate(categoriesProvider);
  ref.invalidate(categoryNamesProvider);
}
