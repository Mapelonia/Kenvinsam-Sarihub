import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:kenvinsam_sarihub/utils/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  // Increment this when you change the schema in future updates
<<<<<<< HEAD
  static const int _dbVersion = 8;
=======
  static const int _dbVersion = 7;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('kenvinsam_sarihub.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  // ─── Migration system ───
  // Called when upgrading from an older version to a newer one.
  // Each migration step handles one version bump.
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    // Migration from v1 → v2: Remove sales table, remove stock_quantity
    if (oldVersion < 2) {
      // Drop sales table (no longer needed)
      await db.execute('DROP TABLE IF EXISTS sales');

      // Remove stock_quantity from products (SQLite doesn't support DROP COLUMN
      // on older versions, so we recreate the table)
      await db.execute('''
        CREATE TABLE IF NOT EXISTS products_new (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          category TEXT NOT NULL,
          capital_price REAL NOT NULL,
          selling_price REAL NOT NULL,
          image_path TEXT,
          supplier_name TEXT,
          supplier_contact TEXT,
          barcode TEXT,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL
        )
      ''');

      // Copy data (skip stock_quantity)
      await db.execute('''
        INSERT INTO products_new (id, name, category, capital_price, selling_price,
          image_path, supplier_name, supplier_contact, barcode, created_at, updated_at)
        SELECT id, name, category, capital_price, selling_price,
          image_path, supplier_name, supplier_contact, barcode, created_at, updated_at
        FROM products
      ''');

      await db.execute('DROP TABLE products');
      await db.execute('ALTER TABLE products_new RENAME TO products');

      // Add electric_units and electric_bill_history if they don't exist
      await db.execute('''
        CREATE TABLE IF NOT EXISTS electric_units (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          unit_name TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS electric_bill_history (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          unit_id INTEGER NOT NULL,
          previous_reading REAL NOT NULL,
          present_reading REAL NOT NULL,
          rate_per_kwh REAL NOT NULL,
          consumption REAL NOT NULL,
          total_bill REAL NOT NULL,
          billing_month TEXT NOT NULL,
          notes TEXT,
          created_at TEXT NOT NULL,
          FOREIGN KEY (unit_id) REFERENCES electric_units (id)
        )
      ''');

      // Insert default electric units if empty
      final existingUnits = await db.query('electric_units');
      if (existingUnits.isEmpty) {
        final defaultUnits = ['Unit A', 'Unit B', 'Unit C', 'Unit D', 'Unit E'];
        for (final unit in defaultUnits) {
          await db.insert('electric_units', {
            'unit_name': unit,
            'created_at': DateTime.now().toIso8601String(),
          });
        }
      }

      // Drop old electric_bills table if it exists
      await db.execute('DROP TABLE IF EXISTS electric_bills');
    }

    // Migration v2 → v3: Add new default categories
    if (oldVersion < 3) {
      final newCategories = ['Personal Needs', 'Medicine', 'Candies'];
      for (final cat in newCategories) {
        await db.insert(
          'categories',
          {'name': cat, 'icon_name': cat.toLowerCase().replaceAll(' ', '_')},
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    }

    // Migration v3 → v4: Add description column to products
    if (oldVersion < 4) {
      await db.execute(
        'ALTER TABLE products ADD COLUMN description TEXT',
      );
    }

    // Migration v4 → v5: Add new electric bill fields
    if (oldVersion < 5) {
      await db.execute('ALTER TABLE electric_bill_history ADD COLUMN other_charges REAL NOT NULL DEFAULT 0');
      await db.execute('ALTER TABLE electric_bill_history ADD COLUMN billing_date TEXT');
      await db.execute("ALTER TABLE electric_bill_history ADD COLUMN payment_status TEXT NOT NULL DEFAULT 'unpaid'");
    }

    // Migration v5 → v6: Add calculator history table
    if (oldVersion < 6) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS calc_history (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          expression TEXT NOT NULL,
          result TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');
    }

    // Migration v6 → v7: Remove suppliers table and supplier fields from products
    if (oldVersion < 7) {
      await db.execute('DROP TABLE IF EXISTS suppliers');

      // Recreate products table without supplier_name and supplier_contact
      await db.execute('''
        CREATE TABLE IF NOT EXISTS products_clean (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          category TEXT NOT NULL,
          capital_price REAL NOT NULL,
          selling_price REAL NOT NULL,
          image_path TEXT,
          description TEXT,
          barcode TEXT,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL
        )
      ''');
      await db.execute('''
        INSERT INTO products_clean (id, name, category, capital_price, selling_price,
          image_path, description, barcode, created_at, updated_at)
        SELECT id, name, category, capital_price, selling_price,
          image_path, description, barcode, created_at, updated_at
        FROM products
      ''');
      await db.execute('DROP TABLE products');
      await db.execute('ALTER TABLE products_clean RENAME TO products');
    }

<<<<<<< HEAD
    // Migration v7 → v8: Add connected_devices and sync_log tables for LAN sync
    if (oldVersion < 8) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS connected_devices (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          device_name TEXT NOT NULL,
          device_ip TEXT NOT NULL,
          pairing_code TEXT NOT NULL,
          is_approved INTEGER NOT NULL DEFAULT 0,
          last_synced TEXT,
          connected_at TEXT NOT NULL,
          status TEXT NOT NULL DEFAULT 'offline'
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS sync_log (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          device_name TEXT NOT NULL,
          device_ip TEXT NOT NULL,
          sync_type TEXT NOT NULL,
          items_synced INTEGER NOT NULL DEFAULT 0,
          status TEXT NOT NULL,
          synced_at TEXT NOT NULL
        )
      ''');
    }

    // Future migrations go here:
    // if (oldVersion < 9) { ... }
=======
    // Future migrations go here:
    // if (oldVersion < 8) { ... }
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  }

  // ─── Fresh install schema (version 2) ───
  Future<void> _createDB(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT NOT NULL,
        display_name TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // Categories table
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        icon_name TEXT
      )
    ''');

    // Products table (no stock_quantity)
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        capital_price REAL NOT NULL,
        selling_price REAL NOT NULL,
        image_path TEXT,
        description TEXT,
        barcode TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Price history table
    await db.execute('''
      CREATE TABLE price_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        product_name TEXT NOT NULL,
        old_capital_price REAL NOT NULL,
        new_capital_price REAL NOT NULL,
        old_selling_price REAL NOT NULL,
        new_selling_price REAL NOT NULL,
        reason TEXT,
        changed_at TEXT NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');

    // Electric units table
    await db.execute('''
      CREATE TABLE electric_units (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        unit_name TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Electric bill history table
    await db.execute('''
      CREATE TABLE electric_bill_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        unit_id INTEGER NOT NULL,
        previous_reading REAL NOT NULL,
        present_reading REAL NOT NULL,
        rate_per_kwh REAL NOT NULL,
        consumption REAL NOT NULL,
        other_charges REAL NOT NULL DEFAULT 0,
        total_bill REAL NOT NULL,
        billing_month TEXT NOT NULL,
        billing_date TEXT,
        notes TEXT,
        payment_status TEXT NOT NULL DEFAULT 'unpaid',
        created_at TEXT NOT NULL,
        FOREIGN KEY (unit_id) REFERENCES electric_units (id)
      )
    ''');

    // Sessions table
    await db.execute('''
      CREATE TABLE sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        username TEXT NOT NULL,
        role TEXT NOT NULL,
        login_time TEXT NOT NULL,
        logout_time TEXT,
        is_active INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // Connected devices table for LAN sync
    await db.execute('''
      CREATE TABLE connected_devices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        device_name TEXT NOT NULL,
        device_ip TEXT NOT NULL,
        pairing_code TEXT NOT NULL,
        is_approved INTEGER NOT NULL DEFAULT 0,
        last_synced TEXT,
        connected_at TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'offline'
      )
    ''');

    // Sync log table
    await db.execute('''
      CREATE TABLE sync_log (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        device_name TEXT NOT NULL,
        device_ip TEXT NOT NULL,
        sync_type TEXT NOT NULL,
        items_synced INTEGER NOT NULL DEFAULT 0,
        status TEXT NOT NULL,
        synced_at TEXT NOT NULL
      )
    ''');

    // Calculator history table
    await db.execute('''
      CREATE TABLE calc_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        expression TEXT NOT NULL,
        result TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Insert default users
    await db.insert('users', {
      'username': AppConstants.defaultAdminUsername,
      'password': AppConstants.defaultAdminPassword,
      'role': AppConstants.roleAdmin,
      'display_name': 'Kenvinsam',
      'created_at': DateTime.now().toIso8601String(),
    });

    await db.insert('users', {
      'username': AppConstants.defaultFamilyUsername,
      'password': AppConstants.defaultFamilyPassword,
      'role': AppConstants.roleFamily,
      'display_name': 'Razo',
      'created_at': DateTime.now().toIso8601String(),
    });

    // Insert default categories
    for (final category in AppConstants.categories) {
      await db.insert('categories', {
        'name': category,
        'icon_name': category.toLowerCase().replaceAll(' ', '_'),
      });
    }

<<<<<<< HEAD
=======
    // Insert the extra default categories
    final extraCategories = ['Personal Needs', 'Medicine', 'Candies'];
    for (final cat in extraCategories) {
      await db.insert('categories', {
        'name': cat,
        'icon_name': cat.toLowerCase().replaceAll(' ', '_'),
      });
    }

>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    // Insert sample products
    await _insertSampleProducts(db);

    // Insert default electric units
    final defaultUnits = ['Unit A', 'Unit B', 'Unit C', 'Unit D', 'Unit E'];
    for (final unit in defaultUnits) {
      await db.insert('electric_units', {
        'unit_name': unit,
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<void> _insertSampleProducts(Database db) async {
    final sampleProducts = [
      {'name': 'Lucky Me Pancit Canton', 'category': 'Instant Foods', 'capital_price': 9.0, 'selling_price': 12.0},
      {'name': 'Nissin Cup Noodles', 'category': 'Instant Foods', 'capital_price': 22.0, 'selling_price': 28.0},
      {'name': 'Argentina Corned Beef 150g', 'category': 'Canned Goods', 'capital_price': 28.0, 'selling_price': 35.0},
      {'name': 'Century Tuna 155g', 'category': 'Canned Goods', 'capital_price': 24.0, 'selling_price': 30.0},
      {'name': 'Skyflakes Crackers', 'category': 'Biscuits', 'capital_price': 8.0, 'selling_price': 10.0},
      {'name': 'Piattos Cheese', 'category': 'Junk Foods', 'capital_price': 12.0, 'selling_price': 15.0},
      {'name': 'Coca-Cola 1.5L', 'category': 'Beverages', 'capital_price': 52.0, 'selling_price': 65.0},
      {'name': 'Nescafe 3-in-1', 'category': 'Coffee & Powdered Drinks', 'capital_price': 7.0, 'selling_price': 9.0},
      {'name': 'Safeguard Soap', 'category': 'Hygiene', 'capital_price': 32.0, 'selling_price': 40.0},
      {'name': 'Silver Swan Soy Sauce 1L', 'category': 'Cooking Essentials', 'capital_price': 38.0, 'selling_price': 48.0},
      {'name': 'Magnolia Ice Cream 750ml', 'category': 'Frozen Foods', 'capital_price': 85.0, 'selling_price': 105.0},
      {'name': 'Marlboro Red', 'category': 'Cigarettes', 'capital_price': 130.0, 'selling_price': 150.0},
      {'name': 'Tide Powder 80g', 'category': 'Laundry', 'capital_price': 10.0, 'selling_price': 13.0},
      {'name': 'Joy Dishwashing Liquid 250ml', 'category': 'Cleaning Supplies', 'capital_price': 45.0, 'selling_price': 55.0},
      {'name': 'Pampers Diaper Small', 'category': 'Baby Products', 'capital_price': 8.0, 'selling_price': 11.0},
    ];

    final now = DateTime.now().toIso8601String();
    for (final p in sampleProducts) {
      await db.insert('products', {...p, 'created_at': now, 'updated_at': now});
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
