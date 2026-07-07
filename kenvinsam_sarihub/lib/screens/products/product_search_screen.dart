import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/models/product.dart';
import 'package:kenvinsam_sarihub/services/product_service.dart';
import 'package:kenvinsam_sarihub/services/category_service.dart';
import 'package:kenvinsam_sarihub/screens/products/product_detail_screen.dart';
import 'package:kenvinsam_sarihub/widgets/product_card.dart';
<<<<<<< HEAD
=======
import 'package:kenvinsam_sarihub/widgets/app_search_bar.dart';
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
import 'package:kenvinsam_sarihub/widgets/empty_state_widget.dart';
import 'package:kenvinsam_sarihub/utils/page_transitions.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class ProductSearchScreen extends ConsumerStatefulWidget {
  final String? initialCategory;

  const ProductSearchScreen({super.key, this.initialCategory});

  @override
  ConsumerState<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends ConsumerState<ProductSearchScreen> {
  final _searchController = TextEditingController();
  final _productService = ProductService();
  final _categoryService = CategoryService();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String? _selectedCategory;
  bool _isLoading = true;
  List<String> _categoryNames = [];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _loadAll();
  }

  Future<void> _loadAll() async {
    setState(() => _isLoading = true);
    final names = await _categoryService.getAllCategoryNames();
    if (_selectedCategory != null) {
      _products = await _productService.getProductsByCategory(_selectedCategory!);
    } else {
      _products = await _productService.getAllProducts();
    }
    _filteredProducts = _products;
    setState(() {
      _categoryNames = names;
      _isLoading = false;
    });
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    if (_selectedCategory != null) {
      _products = await _productService.getProductsByCategory(_selectedCategory!);
    } else {
      _products = await _productService.getAllProducts();
    }
    _filteredProducts = _products;
<<<<<<< HEAD
    _filterProducts(_searchController.text);
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    setState(() => _isLoading = false);
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Products',
          style: AppTheme.headingMd.copyWith(color: context.textPrimary),
        ),
      ),
=======
    return Scaffold(
      appBar: AppBar(title: const Text('Search Products')),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTheme.spaceLg,
              AppTheme.spaceLg,
              AppTheme.spaceLg,
              AppTheme.spaceMd,
            ),
<<<<<<< HEAD
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.cardDark : const Color(0xFFE8ECF0),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.06)
                      : Colors.transparent,
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterProducts,
                autofocus: true,
                style: AppTheme.bodyMd.copyWith(color: context.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search by product name...',
                  hintStyle: AppTheme.bodyMd.copyWith(color: context.textMuted),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: context.textMuted,
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            _filterProducts('');
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: context.textMuted,
                            size: 18,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spaceLg,
                    vertical: AppTheme.spaceLg,
                  ),
                  filled: false,
                ),
              ),
=======
            child: AppSearchBar(
              controller: _searchController,
              hintText: 'Search by product name...',
              onChanged: _filterProducts,
              onClear: () {
                _searchController.clear();
                _filterProducts('');
              },
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            ),
          ),

          // Category Filter
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
              itemCount: _categoryNames.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: AppTheme.spaceSm),
              itemBuilder: (context, index) {
                if (index == 0) {
<<<<<<< HEAD
                  return _CategoryChip(
                    label: 'All',
                    isSelected: _selectedCategory == null,
                    onTap: () {
=======
                  return FilterChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (_) {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                      setState(() => _selectedCategory = null);
                      _loadProducts();
                    },
                  );
                }
                final category = _categoryNames[index - 1];
<<<<<<< HEAD
                return _CategoryChip(
                  label: category,
                  isSelected: _selectedCategory == category,
                  onTap: () {
=======
                return FilterChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (_) {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                    setState(() => _selectedCategory = category);
                    _loadProducts();
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
            child: Row(
              children: [
                Text(
                  '${_filteredProducts.length} ${_filteredProducts.length == 1 ? "product" : "products"} found',
<<<<<<< HEAD
                  style: AppTheme.caption.copyWith(color: context.textMuted),
                ),
                if (_selectedCategory != null) ...[
                  const SizedBox(width: AppTheme.spaceSm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusFull),
                    ),
                    child: Text(
                      _selectedCategory!,
                      style: AppTheme.caption.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
=======
                  style: AppTheme.caption.copyWith(color: context.textSecondary),
                ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),

          // Product List
          Expanded(
            child: _isLoading
<<<<<<< HEAD
                ? Center(
                    child: CircularProgressIndicator(
                      color: context.primaryColor,
                      strokeWidth: 3,
                    ),
                  )
                : _filteredProducts.isEmpty
                    ? const EmptyStateWidget(
                        icon: Icons.search_off_rounded,
=======
                ? const Center(child: CircularProgressIndicator())
                : _filteredProducts.isEmpty
                    ? const EmptyStateWidget(
                        icon: Icons.search_off,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                        title: 'No products found',
                        subtitle: 'Try a different search or category',
                      )
                    : ListView.builder(
<<<<<<< HEAD
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spaceLg),
=======
                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: _filteredProducts[index],
                            onTap: () async {
                              await context.pushPage(
                                ProductDetailScreen(
                                  product: _filteredProducts[index],
                                ),
                              );
                              _loadProducts();
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
<<<<<<< HEAD

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final selectedColor = isDark ? AppTheme.lightGreen : AppTheme.primaryGreen;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor.withOpacity(isDark ? 0.15 : 0.1)
              : isDark
                  ? AppTheme.cardDark
                  : const Color(0xFFE8ECF0),
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(
            color: isSelected
                ? selectedColor.withOpacity(0.3)
                : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: AppTheme.caption.copyWith(
            color: isSelected ? selectedColor : context.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
