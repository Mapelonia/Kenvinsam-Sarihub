import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:kenvinsam_sarihub/models/product.dart';
import 'package:kenvinsam_sarihub/services/product_service.dart';
import 'package:kenvinsam_sarihub/providers/product_provider.dart';
import 'package:kenvinsam_sarihub/providers/category_provider.dart';
import 'package:kenvinsam_sarihub/widgets/app_snackbar.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  final Product? product;

  const AddProductScreen({super.key, this.product});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _capitalPriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _descriptionController = TextEditingController();

<<<<<<< HEAD
  // Per Piece Calculator controllers
  final _bulkCapitalController = TextEditingController();
  final _quantityController = TextEditingController();
  final _perPieceSellingController = TextEditingController();

  // Price Suggester controllers
  final _suggesterCapitalController = TextEditingController();
  final _suggesterPercentController = TextEditingController();

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  String? _selectedCategory;
  String? _imagePath;
  bool _isLoading = false;
  List<String> _categoryNames = [];

<<<<<<< HEAD
  // Tool expansion states
  bool _showPerPieceTool = false;
  bool _showSuggesterTool = false;

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    if (isEditing) {
      final prod = widget.product!;
      _nameController.text = prod.name;
      _capitalPriceController.text = prod.capitalPrice.toString();
      _sellingPriceController.text = prod.sellingPrice.toString();
      _descriptionController.text = prod.description ?? '';
      _selectedCategory = prod.category;
      _imagePath = prod.imagePath;
    }
  }

  Future<void> _loadCategories() async {
    final service = ref.read(categoryServiceProvider);
    final names = await service.getAllCategoryNames();
    setState(() {
      _categoryNames = names;
      if (_selectedCategory == null && names.isNotEmpty) {
        _selectedCategory = names.first;
      }
      if (isEditing &&
          _selectedCategory != null &&
          !names.contains(_selectedCategory)) {
        _categoryNames = [_selectedCategory!, ...names];
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _capitalPriceController.dispose();
    _sellingPriceController.dispose();
    _descriptionController.dispose();
<<<<<<< HEAD
    _bulkCapitalController.dispose();
    _quantityController.dispose();
    _perPieceSellingController.dispose();
    _suggesterCapitalController.dispose();
    _suggesterPercentController.dispose();
    super.dispose();
  }

=======
    super.dispose();
  }

  /// Show bottom sheet to choose camera, gallery, or remove image
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusXl)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppTheme.spaceLg),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text('Product Image', style: AppTheme.headingMd),
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                'Take a photo or choose from gallery',
                style: AppTheme.bodySm.copyWith(color: context.textSecondary),
              ),
              const SizedBox(height: AppTheme.spaceLg),
              _ImageOptionTile(
                icon: Icons.camera_alt_rounded,
                label: 'Take Photo',
                color: AppTheme.primaryGreen,
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
              const SizedBox(height: AppTheme.spaceMd),
              _ImageOptionTile(
                icon: Icons.photo_library_rounded,
                label: 'Choose from Gallery',
                color: AppTheme.info,
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (_imagePath != null) ...[
                const SizedBox(height: AppTheme.spaceMd),
                _ImageOptionTile(
                  icon: Icons.delete_outline_rounded,
                  label: 'Remove Image',
                  color: AppTheme.error,
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() => _imagePath = null);
                  },
                ),
              ],
              const SizedBox(height: AppTheme.spaceMd),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 80,
    );

    if (image != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${p.basename(image.path)}';
      final savedImage =
          await File(image.path).copy('${appDir.path}/$fileName');
      setState(() => _imagePath = savedImage.path);
    }
  }

<<<<<<< HEAD
  /// Apply Per Piece result to the main form
  void _applyPerPieceResult() {
    final bulkCapital = double.tryParse(_bulkCapitalController.text) ?? 0;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final perPieceSelling = double.tryParse(_perPieceSellingController.text) ?? 0;

    if (quantity > 0) {
      final capitalPerPiece = bulkCapital / quantity;
      _capitalPriceController.text = capitalPerPiece.toStringAsFixed(2);
    }
    if (perPieceSelling > 0) {
      _sellingPriceController.text = perPieceSelling.toStringAsFixed(2);
    }
    setState(() {});
    AppSnackbar.show(context, 'Prices applied to form', type: SnackbarType.success);
  }

  /// Apply Suggester result to the main form
  void _applySuggesterResult() {
    final capital = double.tryParse(_suggesterCapitalController.text) ?? 0;
    final percent = double.tryParse(_suggesterPercentController.text) ?? 0;

    if (capital > 0) {
      _capitalPriceController.text = capital.toStringAsFixed(2);
      final suggested = Helpers.suggestSellingPrice(capital, percent);
      _sellingPriceController.text = suggested.toStringAsFixed(2);
    }
    setState(() {});
    AppSnackbar.show(context, 'Prices applied to form', type: SnackbarType.success);
  }

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      AppSnackbar.show(context, 'Please select a category',
          type: SnackbarType.warning);
      return;
    }

    setState(() => _isLoading = true);

    final product = Product(
      id: widget.product?.id,
      name: _nameController.text.trim(),
      category: _selectedCategory!,
      capitalPrice: double.parse(_capitalPriceController.text),
      sellingPrice: double.parse(_sellingPriceController.text),
      imagePath: _imagePath,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      createdAt: widget.product?.createdAt,
    );

    final service = ProductService();
    if (isEditing) {
      await service.updateProduct(product);
    } else {
      await service.addProduct(product);
    }

    refreshProducts(ref);
    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.pop(context);
      AppSnackbar.show(
        context,
        isEditing ? 'Product updated' : 'Product added',
        type: SnackbarType.success,
      );
    }
  }

<<<<<<< HEAD

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  @override
  Widget build(BuildContext context) {
    final capitalPrice = double.tryParse(_capitalPriceController.text) ?? 0;
    final sellingPrice = double.tryParse(_sellingPriceController.text) ?? 0;
    final profit = Helpers.calculateProfit(capitalPrice, sellingPrice);
    final profitPercent =
        Helpers.calculateProfitPercentage(capitalPrice, sellingPrice);
<<<<<<< HEAD
    final hasImage = _imagePath != null && File(_imagePath!).existsSync();
    final isDark = context.isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Product' : 'Add Product',
          style: AppTheme.headingMd.copyWith(color: context.textPrimary),
        ),
      ),
=======
    final hasImage =
        _imagePath != null && File(_imagePath!).existsSync();

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Product' : 'Add Product')),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ─── Image Picker ───
              GestureDetector(
                onTap: _showImageOptions,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
<<<<<<< HEAD
                    color: isDark
                        ? AppTheme.cardDark
=======
                    color: context.isDark
                        ? Colors.grey.shade900
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                        : AppTheme.paleGreen,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(
                      color: AppTheme.primaryGreen.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: hasImage
                      ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusLg),
                              child: Image.file(
                                File(_imagePath!),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
<<<<<<< HEAD
=======
                            // Overlay edit button
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.edit_rounded,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppTheme.spaceMd),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryGreen.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_a_photo_rounded,
                                size: 32,
                                color: AppTheme.primaryGreen,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spaceMd),
                            Text(
                              'Tap to add photo',
                              style: AppTheme.bodyMd.copyWith(
                                color: AppTheme.primaryGreen,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
<<<<<<< HEAD
=======
                            const SizedBox(height: 4),
                            Text(
                              'Camera or Gallery',
                              style: AppTheme.caption.copyWith(
                                color: AppTheme.primaryGreen.withOpacity(0.7),
                              ),
                            ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                          ],
                        ),
                ),
              ),
              const SizedBox(height: AppTheme.space2xl),

              // ─── Product Information ───
              _sectionLabel('Product Information'),
              const SizedBox(height: AppTheme.spaceSm),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                ),
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: AppTheme.spaceMd),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: _categoryNames
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedCategory = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              const SizedBox(height: AppTheme.spaceMd),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  prefixIcon: Icon(Icons.notes_rounded),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: AppTheme.space2xl),

              // ─── Pricing ───
              _sectionLabel('Pricing'),
              const SizedBox(height: AppTheme.spaceSm),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _capitalPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Capital Price',
                        prefixText: '₱ ',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) =>
                          v?.isEmpty == true ? 'Required' : null,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spaceMd),
                  Expanded(
                    child: TextFormField(
                      controller: _sellingPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Selling Price',
                        prefixText: '₱ ',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) =>
                          v?.isEmpty == true ? 'Required' : null,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spaceMd),
              if (capitalPrice > 0 && sellingPrice > 0)
                _buildProfitPreview(profit, profitPercent),
              const SizedBox(height: AppTheme.space2xl),

<<<<<<< HEAD
              // ─── Pricing Tools ───
              _sectionLabel('Pricing Tools'),
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                'Use these tools to calculate your prices without leaving this screen',
                style: AppTheme.caption.copyWith(color: context.textMuted),
              ),
              const SizedBox(height: AppTheme.spaceMd),

              // Per Piece Calculator
              _buildPerPieceCalculator(isDark),
              const SizedBox(height: AppTheme.spaceMd),

              // Price Suggester
              _buildPriceSuggester(isDark),
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              const SizedBox(height: AppTheme.space3xl),

              // ─── Save ───
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveProduct,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Icon(isEditing ? Icons.save_rounded : Icons.add_rounded),
                label: Text(isEditing ? 'Update Product' : 'Add Product'),
              ),
<<<<<<< HEAD
              const SizedBox(height: AppTheme.spaceLg),
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            ],
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  // ─── Per Piece Calculator Inline Tool ───
  Widget _buildPerPieceCalculator(bool isDark) {
    final bulkCapital = double.tryParse(_bulkCapitalController.text) ?? 0;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final perPieceSelling = double.tryParse(_perPieceSellingController.text) ?? 0;
    final capitalPerPiece = quantity > 0 ? bulkCapital / quantity : 0.0;
    final profitPerPiece = perPieceSelling > 0 && capitalPerPiece > 0
        ? perPieceSelling - capitalPerPiece
        : 0.0;
    final hasResult = capitalPerPiece > 0;

    return _ToolCard(
      title: 'Per Piece Calculator',
      subtitle: 'Calculate capital per piece from bulk',
      icon: Icons.shopping_bag_rounded,
      color: AppTheme.info,
      isExpanded: _showPerPieceTool,
      onToggle: () => setState(() => _showPerPieceTool = !_showPerPieceTool),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _bulkCapitalController,
            decoration: const InputDecoration(
              labelText: 'Bulk Capital Price',
              prefixText: '₱ ',
              hintText: 'e.g. 580',
              prefixIcon: Icon(Icons.payments_outlined),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          TextField(
            controller: _quantityController,
            decoration: const InputDecoration(
              labelText: 'Quantity (pieces)',
              hintText: 'e.g. 20',
              prefixIcon: Icon(Icons.inventory_2_outlined),
            ),
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          TextField(
            controller: _perPieceSellingController,
            decoration: const InputDecoration(
              labelText: 'Selling Price per Piece',
              prefixText: '₱ ',
              prefixIcon: Icon(Icons.sell_outlined),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),

          // Result
          if (hasResult) ...[
            const SizedBox(height: AppTheme.spaceLg),
            Container(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              decoration: BoxDecoration(
                color: isDark
                    ? AppTheme.info.withOpacity(0.08)
                    : AppTheme.info.withOpacity(0.04),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: AppTheme.info.withOpacity(0.15)),
              ),
              child: Column(
                children: [
                  _toolResultRow(
                    'Capital per piece',
                    Helpers.formatCurrency(capitalPerPiece),
                    AppTheme.info,
                  ),
                  if (profitPerPiece != 0) ...[
                    const SizedBox(height: AppTheme.spaceSm),
                    _toolResultRow(
                      'Profit per piece',
                      Helpers.formatCurrency(profitPerPiece),
                      profitPerPiece >= 0 ? AppTheme.success : AppTheme.error,
                    ),
                  ],
                ],
              ),
            ),
          ],

          // Apply button
          if (hasResult) ...[
            const SizedBox(height: AppTheme.spaceMd),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _applyPerPieceResult,
                icon: const Icon(Icons.check_rounded, size: 18),
                label: const Text('Apply to Form'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.info,
                  side: BorderSide(color: AppTheme.info.withOpacity(0.5)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─── Price Suggester Inline Tool ───
  Widget _buildPriceSuggester(bool isDark) {
    final capital = double.tryParse(_suggesterCapitalController.text) ?? 0;
    final percent = double.tryParse(_suggesterPercentController.text) ?? 0;
    final suggestedPrice = capital > 0
        ? Helpers.suggestSellingPrice(capital, percent)
        : 0.0;
    final expectedProfit = suggestedPrice - capital;
    final hasResult = capital > 0 && percent > 0;

    return _ToolCard(
      title: 'Price Suggester',
      subtitle: 'Get suggested selling price from profit %',
      icon: Icons.lightbulb_rounded,
      color: AppTheme.warning,
      isExpanded: _showSuggesterTool,
      onToggle: () => setState(() => _showSuggesterTool = !_showSuggesterTool),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _suggesterCapitalController,
            decoration: const InputDecoration(
              labelText: 'Capital Price',
              prefixText: '₱ ',
              prefixIcon: Icon(Icons.payments_outlined),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          TextField(
            controller: _suggesterPercentController,
            decoration: const InputDecoration(
              labelText: 'Desired Profit %',
              suffixText: '%',
              prefixIcon: Icon(Icons.percent_rounded),
              hintText: 'e.g. 30',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),

          // Result
          if (hasResult) ...[
            const SizedBox(height: AppTheme.spaceLg),
            Container(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              decoration: BoxDecoration(
                color: isDark
                    ? AppTheme.warning.withOpacity(0.08)
                    : AppTheme.warning.withOpacity(0.04),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: AppTheme.warning.withOpacity(0.15)),
              ),
              child: Column(
                children: [
                  _toolResultRow(
                    'Suggested selling price',
                    Helpers.formatCurrency(suggestedPrice),
                    AppTheme.warning,
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  _toolResultRow(
                    'Expected profit',
                    Helpers.formatCurrency(expectedProfit),
                    AppTheme.success,
                  ),
                ],
              ),
            ),
          ],

          // Apply button
          if (hasResult) ...[
            const SizedBox(height: AppTheme.spaceMd),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _applySuggesterResult,
                icon: const Icon(Icons.check_rounded, size: 18),
                label: const Text('Apply to Form'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.warning,
                  side: BorderSide(color: AppTheme.warning.withOpacity(0.5)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _toolResultRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTheme.bodySm.copyWith(color: context.textSecondary)),
        Text(
          value,
          style: AppTheme.bodyMd.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }


=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: AppTheme.label.copyWith(
        color: context.textSecondary,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildProfitPreview(double profit, double profitPercent) {
    final isPositive = profit >= 0;
    final color = isPositive ? AppTheme.success : AppTheme.error;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(
            isPositive
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            color: color,
            size: 20,
          ),
          const SizedBox(width: AppTheme.spaceSm),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
<<<<<<< HEAD
=======
                  crossAxisAlignment: CrossAxisAlignment.start,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                  children: [
                    Text('Profit',
                        style: AppTheme.caption
                            .copyWith(color: context.textSecondary)),
                    Text(
                      Helpers.formatCurrency(profit),
                      style: AppTheme.bodyLg.copyWith(
                          fontWeight: FontWeight.w700, color: color),
                    ),
                  ],
                ),
                Column(
<<<<<<< HEAD
=======
                  crossAxisAlignment: CrossAxisAlignment.start,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                  children: [
                    Text('Margin',
                        style: AppTheme.caption
                            .copyWith(color: context.textSecondary)),
                    Text(
                      '${profitPercent.toStringAsFixed(1)}%',
                      style: AppTheme.bodyLg.copyWith(
                          fontWeight: FontWeight.w700, color: color),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

<<<<<<< HEAD
// ─── Expandable Tool Card ───
class _ToolCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;

  const _ToolCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isExpanded
              ? color.withOpacity(0.3)
              : isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.grey.shade200,
        ),
        boxShadow: isDark ? null : AppTheme.shadowSm,
      ),
      child: Column(
        children: [
          // Header (always visible)
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spaceLg),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: color.withOpacity(isDark ? 0.15 : 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(width: AppTheme.spaceMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTheme.bodyMd.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.textPrimary,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: AppTheme.caption.copyWith(
                            color: context.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: context.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spaceLg,
                0,
                AppTheme.spaceLg,
                AppTheme.spaceLg,
              ),
              child: child,
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
            sizeCurve: Curves.easeOutCubic,
          ),
        ],
      ),
    );
  }
}

// ─── Image Option Tile ───
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
class _ImageOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ImageOptionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Text(
                label,
<<<<<<< HEAD
                style: AppTheme.bodyMd.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
=======
                style:
                    AppTheme.bodyMd.copyWith(color: color, fontWeight: FontWeight.w600),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
