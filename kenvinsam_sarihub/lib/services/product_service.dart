import 'package:sqflite/sqflite.dart';
import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/models/product.dart';
import 'package:kenvinsam_sarihub/models/price_history.dart';
import 'package:kenvinsam_sarihub/services/lan_server_service.dart';

class ProductService {
  final _lanServer = LanServerService.instance;

  Future<List<Product>> getAllProducts() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query('products', orderBy: 'updated_at DESC');
    return results.map((map) => Product.fromMap(map)).toList();
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'products',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'name ASC',
    );
    return results.map((map) => Product.fromMap(map)).toList();
  }

  Future<List<Product>> searchProducts(String query) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'products',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'name ASC',
    );
    return results.map((map) => Product.fromMap(map)).toList();
  }

  Future<Product?> getProductById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return Product.fromMap(results.first);
    }
    return null;
  }

  Future<int> addProduct(Product product) async {
    final db = await DatabaseHelper.instance.database;
    final id = await db.insert('products', product.toMap());

    // Broadcast to connected clients in real-time
    final inserted = await getProductById(id);
    if (inserted != null) {
      await _lanServer.broadcastProductCreated(inserted.toMap());
    }

    return id;
  }

  Future<int> updateProduct(Product product) async {
    final db = await DatabaseHelper.instance.database;

    // Get old product for price history
    final oldProduct = await getProductById(product.id!);
    bool priceChanged = false;

<<<<<<< HEAD
    // Create the updated product with a single consistent timestamp
    final updatedProduct = product.copyWith(updatedAt: DateTime.now());

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    if (oldProduct != null &&
        (oldProduct.capitalPrice != product.capitalPrice ||
            oldProduct.sellingPrice != product.sellingPrice)) {
      priceChanged = true;
      // Record price change
      final history = PriceHistory(
        productId: product.id!,
        productName: product.name,
        oldCapitalPrice: oldProduct.capitalPrice,
        newCapitalPrice: product.capitalPrice,
        oldSellingPrice: oldProduct.sellingPrice,
        newSellingPrice: product.sellingPrice,
      );
      await addPriceHistory(history);

<<<<<<< HEAD
      // Broadcast price change in real-time (same timestamp as DB)
      await _lanServer.broadcastPriceChanged(
        updatedProduct.toMap(),
=======
      // Broadcast price change in real-time
      await _lanServer.broadcastPriceChanged(
        product.copyWith(updatedAt: DateTime.now()).toMap(),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        history.toMap(),
      );
    }

<<<<<<< HEAD
=======
    final updatedProduct = product.copyWith(updatedAt: DateTime.now());
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    final result = await db.update(
      'products',
      updatedProduct.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );

    // Broadcast product update (if not already broadcast as price change)
    if (!priceChanged) {
      await _lanServer.broadcastProductUpdated(updatedProduct.toMap());
    }

    return result;
  }

  Future<int> deleteProduct(int id) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.delete('products', where: 'id = ?', whereArgs: [id]);

    // Broadcast deletion in real-time
    await _lanServer.broadcastProductDeleted(id);

    return result;
  }

  Future<List<Product>> getRecentlyUpdatedProducts({int limit = 10}) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'products',
      orderBy: 'updated_at DESC',
      limit: limit,
    );
    return results.map((map) => Product.fromMap(map)).toList();
  }

  Future<Map<String, int>> getCategoryProductCounts() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.rawQuery(
      'SELECT category, COUNT(*) as count FROM products GROUP BY category',
    );
    final Map<String, int> counts = {};
    for (final row in results) {
      counts[row['category'] as String] = row['count'] as int;
    }
    return counts;
  }

  Future<int> getTotalProductCount() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM products');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // Price History
  Future<int> addPriceHistory(PriceHistory history) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('price_history', history.toMap());
  }

  Future<List<PriceHistory>> getPriceHistory({int? productId}) async {
    final db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> results;
    if (productId != null) {
      results = await db.query(
        'price_history',
        where: 'product_id = ?',
        whereArgs: [productId],
        orderBy: 'changed_at DESC',
      );
    } else {
      results = await db.query('price_history', orderBy: 'changed_at DESC');
    }
    return results.map((map) => PriceHistory.fromMap(map)).toList();
  }

  Future<List<PriceHistory>> getPriceAlerts() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'price_history',
      where: 'new_selling_price > old_selling_price',
      orderBy: 'changed_at DESC',
      limit: 20,
    );
    return results.map((map) => PriceHistory.fromMap(map)).toList();
  }
}
