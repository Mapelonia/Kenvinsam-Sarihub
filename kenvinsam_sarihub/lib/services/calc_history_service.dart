import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/models/calc_history.dart';

class CalcHistoryService {
  Future<List<CalcHistory>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.query('calc_history', orderBy: 'created_at DESC', limit: 100);
    return results.map((m) => CalcHistory.fromMap(m)).toList();
  }

  Future<int> save(String expression, String result) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert('calc_history', CalcHistory(
      expression: expression,
      result: result,
    ).toMap());
  }

  Future<void> deleteOne(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('calc_history', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAll() async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('calc_history');
  }
}
