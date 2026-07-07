class Product {
  final int? id;
  final String name;
  final String category;
  final double capitalPrice;
  final double sellingPrice;
  final String? imagePath;
  final String? description;
  final String? barcode;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.capitalPrice,
    required this.sellingPrice,
    this.imagePath,
    this.description,
    this.barcode,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  double get profit => sellingPrice - capitalPrice;
  double get profitPercentage =>
      capitalPrice > 0 ? ((sellingPrice - capitalPrice) / capitalPrice) * 100 : 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'capital_price': capitalPrice,
      'selling_price': sellingPrice,
      'image_path': imagePath,
      'description': description,
      'barcode': barcode,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      category: map['category'] as String,
      capitalPrice: (map['capital_price'] as num).toDouble(),
      sellingPrice: (map['selling_price'] as num).toDouble(),
      imagePath: map['image_path'] as String?,
      description: map['description'] as String?,
      barcode: map['barcode'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Product copyWith({
    int? id,
    String? name,
    String? category,
    double? capitalPrice,
    double? sellingPrice,
    String? imagePath,
    String? description,
    String? barcode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      capitalPrice: capitalPrice ?? this.capitalPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
