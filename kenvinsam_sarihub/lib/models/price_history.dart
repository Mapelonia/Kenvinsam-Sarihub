class PriceHistory {
  final int? id;
  final int productId;
  final String productName;
  final double oldCapitalPrice;
  final double newCapitalPrice;
  final double oldSellingPrice;
  final double newSellingPrice;
  final String? reason;
  final DateTime changedAt;

  PriceHistory({
    this.id,
    required this.productId,
    required this.productName,
    required this.oldCapitalPrice,
    required this.newCapitalPrice,
    required this.oldSellingPrice,
    required this.newSellingPrice,
    this.reason,
    DateTime? changedAt,
  }) : changedAt = changedAt ?? DateTime.now();

  bool get isPriceIncrease => newSellingPrice > oldSellingPrice;
  double get priceChange => newSellingPrice - oldSellingPrice;
  double get percentageChange =>
      oldSellingPrice > 0 ? ((newSellingPrice - oldSellingPrice) / oldSellingPrice) * 100 : 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'old_capital_price': oldCapitalPrice,
      'new_capital_price': newCapitalPrice,
      'old_selling_price': oldSellingPrice,
      'new_selling_price': newSellingPrice,
      'reason': reason,
      'changed_at': changedAt.toIso8601String(),
    };
  }

  factory PriceHistory.fromMap(Map<String, dynamic> map) {
    return PriceHistory(
      id: map['id'] as int?,
      productId: map['product_id'] as int,
      productName: map['product_name'] as String,
      oldCapitalPrice: (map['old_capital_price'] as num).toDouble(),
      newCapitalPrice: (map['new_capital_price'] as num).toDouble(),
      oldSellingPrice: (map['old_selling_price'] as num).toDouble(),
      newSellingPrice: (map['new_selling_price'] as num).toDouble(),
      reason: map['reason'] as String?,
      changedAt: DateTime.parse(map['changed_at'] as String),
    );
  }
}
