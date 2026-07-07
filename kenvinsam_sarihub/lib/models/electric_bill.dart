/// Represents an electric billing unit (e.g., Unit A, Unit B)
class ElectricUnit {
  final int? id;
  final String unitName;
  final DateTime createdAt;

  ElectricUnit({
    this.id,
    required this.unitName,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit_name': unitName,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ElectricUnit.fromMap(Map<String, dynamic> map) {
    return ElectricUnit(
      id: map['id'] as int?,
      unitName: map['unit_name'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  ElectricUnit copyWith({int? id, String? unitName, DateTime? createdAt}) {
    return ElectricUnit(
      id: id ?? this.id,
      unitName: unitName ?? this.unitName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// Payment status for a bill record
enum BillPaymentStatus { unpaid, paid, partial }

extension BillPaymentStatusExt on BillPaymentStatus {
  String get label {
    switch (this) {
      case BillPaymentStatus.paid: return 'Paid';
      case BillPaymentStatus.unpaid: return 'Unpaid';
      case BillPaymentStatus.partial: return 'Partial';
    }
  }

  String get value {
    switch (this) {
      case BillPaymentStatus.paid: return 'paid';
      case BillPaymentStatus.unpaid: return 'unpaid';
      case BillPaymentStatus.partial: return 'partial';
    }
  }

  static BillPaymentStatus fromString(String? s) {
    switch (s) {
      case 'paid': return BillPaymentStatus.paid;
      case 'partial': return BillPaymentStatus.partial;
      default: return BillPaymentStatus.unpaid;
    }
  }
}

/// Represents a single electric bill record for a unit
class ElectricBill {
  final int? id;
  final int unitId;
  final double previousReading;
  final double presentReading;
  final double ratePerKwh;
  final double consumption;
  final double otherCharges;
  final double totalBill;
  final String billingMonth;     // Billing period (e.g., "January 2025")
  final DateTime? billingDate;   // Official billing date from provider
  final String? notes;
  final BillPaymentStatus paymentStatus;
  final DateTime createdAt;

  ElectricBill({
    this.id,
    required this.unitId,
    required this.previousReading,
    required this.presentReading,
    required this.ratePerKwh,
    required this.consumption,
    this.otherCharges = 0,
    required this.totalBill,
    required this.billingMonth,
    this.billingDate,
    this.notes,
    this.paymentStatus = BillPaymentStatus.unpaid,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  double get electricityCharge => consumption * ratePerKwh;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit_id': unitId,
      'previous_reading': previousReading,
      'present_reading': presentReading,
      'rate_per_kwh': ratePerKwh,
      'consumption': consumption,
      'other_charges': otherCharges,
      'total_bill': totalBill,
      'billing_month': billingMonth,
      'billing_date': billingDate?.toIso8601String(),
      'notes': notes,
      'payment_status': paymentStatus.value,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ElectricBill.fromMap(Map<String, dynamic> map) {
    return ElectricBill(
      id: map['id'] as int?,
      unitId: map['unit_id'] as int,
      previousReading: (map['previous_reading'] as num).toDouble(),
      presentReading: (map['present_reading'] as num).toDouble(),
      ratePerKwh: (map['rate_per_kwh'] as num).toDouble(),
      consumption: (map['consumption'] as num).toDouble(),
      otherCharges: (map['other_charges'] as num? ?? 0).toDouble(),
      totalBill: (map['total_bill'] as num).toDouble(),
      billingMonth: map['billing_month'] as String,
      billingDate: map['billing_date'] != null
          ? DateTime.parse(map['billing_date'] as String)
          : null,
      notes: map['notes'] as String?,
      paymentStatus: BillPaymentStatusExt.fromString(
          map['payment_status'] as String?),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  ElectricBill copyWith({
    int? id,
    int? unitId,
    double? previousReading,
    double? presentReading,
    double? ratePerKwh,
    double? consumption,
    double? otherCharges,
    double? totalBill,
    String? billingMonth,
    DateTime? billingDate,
    String? notes,
    BillPaymentStatus? paymentStatus,
    DateTime? createdAt,
  }) {
    return ElectricBill(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
      previousReading: previousReading ?? this.previousReading,
      presentReading: presentReading ?? this.presentReading,
      ratePerKwh: ratePerKwh ?? this.ratePerKwh,
      consumption: consumption ?? this.consumption,
      otherCharges: otherCharges ?? this.otherCharges,
      totalBill: totalBill ?? this.totalBill,
      billingMonth: billingMonth ?? this.billingMonth,
      billingDate: billingDate ?? this.billingDate,
      notes: notes ?? this.notes,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
