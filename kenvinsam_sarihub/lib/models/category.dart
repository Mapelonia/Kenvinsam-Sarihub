class Category {
  final int? id;
  final String name;
  final String? iconName;
  final int productCount;

  Category({
    this.id,
    required this.name,
    this.iconName,
    this.productCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon_name': iconName,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int?,
      name: map['name'] as String,
      iconName: map['icon_name'] as String?,
      productCount: map['product_count'] as int? ?? 0,
    );
  }

  Category copyWith({
    int? id,
    String? name,
    String? iconName,
    int? productCount,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      productCount: productCount ?? this.productCount,
    );
  }
}
