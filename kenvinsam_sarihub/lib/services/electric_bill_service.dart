import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/models/electric_bill.dart';
import 'package:kenvinsam_sarihub/services/realtime_sync_client.dart';

class ElectricBillService {
  // ─── Unit Operations ───

  Future<List<ElectricUnit>> getAllUnits() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query('electric_units', orderBy: 'created_at ASC');
    return results.map((m) => ElectricUnit.fromMap(m)).toList();
  }

  Future<int> addUnit(ElectricUnit unit) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('electric_units', unit.toMap());
  }

  Future<int> updateUnit(ElectricUnit unit) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'electric_units',
      unit.toMap(),
      where: 'id = ?',
      whereArgs: [unit.id],
    );
  }

  Future<int> deleteUnit(int id) async {
    final db = await DatabaseHelper.instance.database;
    // Delete all bill history for this unit
    await db.delete('electric_bill_history', where: 'unit_id = ?', whereArgs: [id]);
    return await db.delete('electric_units', where: 'id = ?', whereArgs: [id]);
  }

  // ─── Bill History Operations ───

  Future<int> addBillRecord(ElectricBill bill) async {
    final db = await DatabaseHelper.instance.database;
    final id = await db.insert('electric_bill_history', bill.toMap());

    // Auto-push to Admin if connected via LAN
    RealtimeSyncClient.instance.pushElectricBillsNow();

    return id;
  }

  Future<int> updateBillRecord(ElectricBill bill) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.update(
      'electric_bill_history',
      bill.toMap(),
      where: 'id = ?',
      whereArgs: [bill.id],
    );

    // Auto-push to Admin if connected via LAN
    RealtimeSyncClient.instance.pushElectricBillsNow();

    return result;
  }

  Future<int> deleteBillRecord(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('electric_bill_history', where: 'id = ?', whereArgs: [id]);
  }

  /// Get all bill records for a specific unit, ordered by most recent
  Future<List<ElectricBill>> getBillsByUnit(int unitId) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'electric_bill_history',
      where: 'unit_id = ?',
      whereArgs: [unitId],
      orderBy: 'created_at DESC',
    );
    return results.map((m) => ElectricBill.fromMap(m)).toList();
  }

  /// Get the latest bill for a specific unit
  Future<ElectricBill?> getLatestBill(int unitId) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'electric_bill_history',
      where: 'unit_id = ?',
      whereArgs: [unitId],
      orderBy: 'created_at DESC',
      limit: 1,
    );
    if (results.isNotEmpty) {
      return ElectricBill.fromMap(results.first);
    }
    return null;
  }

  /// Get bills grouped by billing month for a unit
  Future<Map<String, List<ElectricBill>>> getBillsGroupedByMonth(int unitId) async {
    final bills = await getBillsByUnit(unitId);
    final Map<String, List<ElectricBill>> grouped = {};
    for (final bill in bills) {
      grouped.putIfAbsent(bill.billingMonth, () => []).add(bill);
    }
    return grouped;
  }

  /// Get bills for a specific month
  Future<List<ElectricBill>> getBillsByMonth(int unitId, String billingMonth) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'electric_bill_history',
      where: 'unit_id = ? AND billing_month = ?',
      whereArgs: [unitId, billingMonth],
      orderBy: 'created_at DESC',
    );
    return results.map((m) => ElectricBill.fromMap(m)).toList();
  }

  /// Check if a bill already exists for a unit in a specific month
  Future<bool> billExistsForMonth(int unitId, String billingMonth) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'electric_bill_history',
      where: 'unit_id = ? AND billing_month = ?',
      whereArgs: [unitId, billingMonth],
    );
    return results.isNotEmpty;
  }

  /// Get total bill amount for a unit across all months
  Future<double> getTotalBillForUnit(int unitId) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      'SELECT SUM(total_bill) as total FROM electric_bill_history WHERE unit_id = ?',
      [unitId],
    );
    if (result.isNotEmpty && result.first['total'] != null) {
      return (result.first['total'] as num).toDouble();
    }
    return 0;
  }

  /// Get average consumption for a unit
  Future<double> getAverageConsumption(int unitId) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      'SELECT AVG(consumption) as avg FROM electric_bill_history WHERE unit_id = ?',
      [unitId],
    );
    if (result.isNotEmpty && result.first['avg'] != null) {
      return (result.first['avg'] as num).toDouble();
    }
    return 0;
  }

  /// Get bill trend data (last 6 months) for a unit
  Future<List<ElectricBill>> getBillTrend(int unitId, {int months = 6}) async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query(
      'electric_bill_history',
      where: 'unit_id = ?',
      whereArgs: [unitId],
      orderBy: 'billing_month DESC',
      limit: months,
    );
    return results.map((m) => ElectricBill.fromMap(m)).toList().reversed.toList();
  }

  /// Get all bill records (for legacy support)
  Future<List<ElectricBill>> getAllBillRecords() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query('electric_bill_history', orderBy: 'created_at DESC');
    return results.map((m) => ElectricBill.fromMap(m)).toList();
  }
}
