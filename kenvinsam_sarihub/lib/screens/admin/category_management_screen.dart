import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kenvinsam_sarihub/models/category.dart';
import 'package:kenvinsam_sarihub/providers/category_provider.dart';
import 'package:kenvinsam_sarihub/providers/product_provider.dart';
import 'package:kenvinsam_sarihub/services/category_service.dart';
import 'package:kenvinsam_sarihub/widgets/app_dialog.dart';
import 'package:kenvinsam_sarihub/widgets/app_snackbar.dart';
import 'package:kenvinsam_sarihub/widgets/empty_state_widget.dart';
import 'package:kenvinsam_sarihub/utils/constants.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class CategoryManagementScreen extends ConsumerStatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  ConsumerState<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState
    extends ConsumerState<CategoryManagementScreen> {
  final _service = CategoryService();

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Categories'),
      ),
      body: categoriesAsync.when(
        data: (categories) {
          if (categories.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.category_rounded,
              title: 'No categories yet',
              subtitle: 'Add your first category',
              action: ElevatedButton.icon(
                onPressed: () => _showAddDialog(context),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Category'),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => refreshCategories(ref),
            child: AnimationLimiter(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppTheme.spaceLg),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 300),
                    child: SlideAnimation(
                      verticalOffset: 20,
                      child: FadeInAnimation(
                        child: _CategoryTile(
                          cat: cat,
                          onEdit: () => _showEditDialog(context, cat),
                          onDelete: () => _confirmDelete(context, cat),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Category'),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
<<<<<<< HEAD
    String selectedIconKey = 'category';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final isDark = Theme.of(ctx).brightness == Brightness.dark;
          final selectedIcon = AppConstants.selectableIcons[selectedIconKey]!;

          return AlertDialog(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Icon(selectedIcon,
                      color: AppTheme.primaryGreen, size: 20),
                ),
                const SizedBox(width: AppTheme.spaceMd),
                const Text('New Category'),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                      hintText: 'e.g. School Supplies',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  Text(
                    'Choose an Icon',
                    style: AppTheme.label.copyWith(
                      color: isDark
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: AppConstants.selectableIcons.length,
                      itemBuilder: (_, index) {
                        final entry = AppConstants.selectableIcons.entries
                            .elementAt(index);
                        final isSelected = entry.key == selectedIconKey;

                        return GestureDetector(
                          onTap: () {
                            setDialogState(
                                () => selectedIconKey = entry.key);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryGreen.withOpacity(0.15)
                                  : isDark
                                      ? AppTheme.cardDarkElevated
                                      : const Color(0xFFE8ECF0),
                              borderRadius: BorderRadius.circular(
                                  AppTheme.radiusSm),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.primaryGreen
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              entry.value,
                              size: 20,
                              color: isSelected
                                  ? AppTheme.primaryGreen
                                  : isDark
                                      ? AppTheme.textMutedDark
                                      : AppTheme.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () =>
                    _saveNew(ctx, controller.text, selectedIconKey),
                child: const Text('Add'),
              ),
            ],
          );
        },
=======

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: const Icon(Icons.add_rounded,
                  color: AppTheme.primaryGreen, size: 20),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            const Text('New Category'),
          ],
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Category Name',
            hintText: 'e.g. School Supplies',
            prefixIcon: Icon(Icons.category_outlined),
          ),
          onSubmitted: (_) => _saveNew(ctx, controller.text),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _saveNew(ctx, controller.text),
            child: const Text('Add'),
          ),
        ],
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }

<<<<<<< HEAD
  Future<void> _saveNew(
      BuildContext ctx, String name, String iconName) async {
=======
  Future<void> _saveNew(BuildContext ctx, String name) async {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    if (name.trim().isEmpty) {
      AppSnackbar.show(ctx, 'Category name cannot be empty',
          type: SnackbarType.warning);
      return;
    }

    final exists = await _service.categoryExists(name);
    if (exists) {
      if (ctx.mounted) {
        AppSnackbar.show(ctx, '"${name.trim()}" already exists',
            type: SnackbarType.warning);
      }
      return;
    }

<<<<<<< HEAD
    await _service.addCategory(name, iconName: iconName);
    refreshCategories(ref);
    refreshProducts(ref);
=======
    await _service.addCategory(name);
    refreshCategories(ref);
    refreshProducts(ref); // so product dropdowns refresh too
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

    if (ctx.mounted) {
      Navigator.pop(ctx);
      AppSnackbar.show(ctx, 'Category "${name.trim()}" added',
          type: SnackbarType.success);
    }
  }

  void _showEditDialog(BuildContext context, Category cat) {
    final controller = TextEditingController(text: cat.name);
<<<<<<< HEAD
    String selectedIconKey = cat.iconName ?? 'category';
    // Ensure the key exists in selectableIcons, fallback to 'category'
    if (!AppConstants.selectableIcons.containsKey(selectedIconKey)) {
      selectedIconKey = 'category';
    }

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final isDark = Theme.of(ctx).brightness == Brightness.dark;
          final selectedIcon = AppConstants.selectableIcons[selectedIconKey]!;

          return AlertDialog(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Icon(selectedIcon, color: AppTheme.info, size: 20),
                ),
                const SizedBox(width: AppTheme.spaceMd),
                const Text('Edit Category'),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  Text(
                    'Choose an Icon',
                    style: AppTheme.label.copyWith(
                      color: isDark
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: AppConstants.selectableIcons.length,
                      itemBuilder: (_, index) {
                        final entry = AppConstants.selectableIcons.entries
                            .elementAt(index);
                        final isSelected = entry.key == selectedIconKey;

                        return GestureDetector(
                          onTap: () {
                            setDialogState(
                                () => selectedIconKey = entry.key);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.info.withOpacity(0.15)
                                  : isDark
                                      ? AppTheme.cardDarkElevated
                                      : const Color(0xFFE8ECF0),
                              borderRadius: BorderRadius.circular(
                                  AppTheme.radiusSm),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.info
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              entry.value,
                              size: 20,
                              color: isSelected
                                  ? AppTheme.info
                                  : isDark
                                      ? AppTheme.textMutedDark
                                      : AppTheme.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () =>
                    _saveEdit(ctx, cat, controller.text, selectedIconKey),
                child: const Text('Save'),
              ),
            ],
          );
        },
=======

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: const Icon(Icons.edit_rounded,
                  color: AppTheme.info, size: 20),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            const Text('Edit Category'),
          ],
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Category Name',
            prefixIcon: Icon(Icons.category_outlined),
          ),
          onSubmitted: (_) => _saveEdit(ctx, cat, controller.text),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _saveEdit(ctx, cat, controller.text),
            child: const Text('Save'),
          ),
        ],
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }

<<<<<<< HEAD
  Future<void> _saveEdit(
      BuildContext ctx, Category cat, String newName, String iconName) async {
=======
  Future<void> _saveEdit(BuildContext ctx, Category cat, String newName) async {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    if (newName.trim().isEmpty) {
      AppSnackbar.show(ctx, 'Category name cannot be empty',
          type: SnackbarType.warning);
      return;
    }

<<<<<<< HEAD
    if (newName.trim() == cat.name && iconName == cat.iconName) {
=======
    if (newName.trim() == cat.name) {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      Navigator.pop(ctx);
      return;
    }

<<<<<<< HEAD
    if (newName.trim() != cat.name) {
      final exists = await _service.categoryExists(newName);
      if (exists) {
        if (ctx.mounted) {
          AppSnackbar.show(ctx, '"${newName.trim()}" already exists',
              type: SnackbarType.warning);
        }
        return;
      }
    }

    await _service.updateCategory(cat.id!, newName, iconName: iconName);
=======
    final exists = await _service.categoryExists(newName);
    if (exists) {
      if (ctx.mounted) {
        AppSnackbar.show(ctx, '"${newName.trim()}" already exists',
            type: SnackbarType.warning);
      }
      return;
    }

    await _service.updateCategory(cat.id!, newName);
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    refreshCategories(ref);
    refreshProducts(ref);

    if (ctx.mounted) {
      Navigator.pop(ctx);
<<<<<<< HEAD
      AppSnackbar.show(ctx, 'Category updated',
=======
      AppSnackbar.show(ctx, 'Category renamed to "${newName.trim()}"',
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          type: SnackbarType.success);
    }
  }

  Future<void> _confirmDelete(BuildContext context, Category cat) async {
    final productCount = await _service.getProductCount(cat.name);

    if (!mounted) return;

    if (productCount > 0) {
      // Can't delete — show info dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: const Icon(Icons.warning_amber_rounded,
                    color: AppTheme.warning, size: 20),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              const Text('Cannot Delete'),
            ],
          ),
          content: Text(
            '"${cat.name}" has $productCount product${productCount == 1 ? '' : 's'} '
            'assigned to it.\n\nReassign or delete those products first before '
            'removing this category.',
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Safe to delete — confirm
    final confirmed = await AppDialog.confirm(
      context: context,
      title: 'Delete Category',
      message: 'Delete "${cat.name}"? This cannot be undone.',
      icon: Icons.delete_rounded,
      confirmLabel: 'Delete',
      destructive: true,
    );

    if (!confirmed || !mounted) return;

    final error = await _service.deleteCategory(cat.id!, cat.name);
    if (error != null) {
      if (mounted) {
        AppSnackbar.show(context, error, type: SnackbarType.error);
      }
      return;
    }

    refreshCategories(ref);
    refreshProducts(ref);
    if (mounted) {
      AppSnackbar.show(context, 'Category "${cat.name}" deleted',
          type: SnackbarType.success);
    }
  }
}

class _CategoryTile extends StatelessWidget {
  final Category cat;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CategoryTile({
    required this.cat,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final icon = AppConstants.iconFor(cat.name, iconName: cat.iconName);
=======
    final icon = AppConstants.iconFor(cat.name);
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    final isDark = context.isDark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spaceMd),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceLg, vertical: AppTheme.spaceSm),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Icon(icon, color: AppTheme.primaryGreen, size: 22),
          ),
          title: Text(
            cat.name,
            style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_rounded, size: 20),
                color: AppTheme.info,
                tooltip: 'Rename',
                onPressed: onEdit,
                splashRadius: 22,
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 20),
                color: AppTheme.error,
                tooltip: 'Delete',
                onPressed: onDelete,
                splashRadius: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
