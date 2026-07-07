import 'package:sqflite/sqflite.dart';
import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/models/category.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/services/lan_server_service.dart';

class CategoryService {
  final _lanServer = LanServerService.instance;

=======

class CategoryService {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  Future<List<Category>> getAllCategories() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query('categories', orderBy: 'name ASC');
    return results.map((m) => Category.fromMap(m)).toList();
  }

  Future<List<String>> getAllCategoryNames() async {
    final categories = await getAllCategories();
    return categories.map((c) => c.name).toList();
  }

<<<<<<< HEAD
  Future<int> addCategory(String name, {String? iconName}) async {
    final db = await DatabaseHelper.instance.database;
    final id = await db.insert(
      'categories',
      {'name': name.trim(), 'icon_name': iconName ?? 'category'},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    // Broadcast category change to connected LAN clients
    await _lanServer.broadcastCategoryUpdated();
    return id;
  }

  Future<int> updateCategory(int id, String newName, {String? iconName}) async {
=======
  Future<int> addCategory(String name) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(
      'categories',
      {'name': name.trim(), 'icon_name': name.toLowerCase().replaceAll(' ', '_')},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> updateCategory(int id, String newName) async {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    final db = await DatabaseHelper.instance.database;

    // Also update all products that reference the old category name
    final old = await db.query('categories', where: 'id = ?', whereArgs: [id]);
    if (old.isNotEmpty) {
      final oldName = old.first['name'] as String;
      await db.update(
        'products',
        {'category': newName.trim()},
        where: 'category = ?',
        whereArgs: [oldName],
      );
    }

<<<<<<< HEAD
    final data = <String, dynamic>{'name': newName.trim()};
    if (iconName != null) {
      data['icon_name'] = iconName;
    }

    final result = await db.update(
      'categories',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );

    // Broadcast category change to connected LAN clients
    await _lanServer.broadcastCategoryUpdated();

    return result;
=======
    return await db.update(
      'categories',
      {'name': newName.trim(), 'icon_name': newName.toLowerCase().replaceAll(' ', '_')},
      where: 'id = ?',
      whereArgs: [id],
    );
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  }

  /// Returns the number of products assigned to this category.
  Future<int> getProductCount(String categoryName) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM products WHERE category = ?',
      [categoryName],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Delete category. Returns error message if products are assigned, null on success.
  Future<String?> deleteCategory(int id, String categoryName) async {
    final count = await getProductCount(categoryName);
    if (count > 0) {
      return '$count product${count == 1 ? ' is' : 's are'} assigned to this category. '
          'Reassign or delete them first.';
    }

    final db = await DatabaseHelper.instance.database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
<<<<<<< HEAD

    // Broadcast category change to connected LAN clients
    await _lanServer.broadcastCategoryUpdated();

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    return null;
  }

  Future<bool> categoryExists(String name) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'categories',
      where: 'LOWER(name) = LOWER(?)',
      whereArgs: [name.trim()],
    );
    return result.isNotEmpty;
  }
}
