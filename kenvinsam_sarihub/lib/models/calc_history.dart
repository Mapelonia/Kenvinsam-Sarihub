class CalcHistory {
  final int? id;
  final String expression;
  final String result;
  final DateTime createdAt;

  CalcHistory({
    this.id,
    required this.expression,
    required this.result,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'expression': expression,
        'result': result,
        'created_at': createdAt.toIso8601String(),
      };

  factory CalcHistory.fromMap(Map<String, dynamic> map) => CalcHistory(
        id: map['id'] as int?,
        expression: map['expression'] as String,
        result: map['result'] as String,
        createdAt: DateTime.parse(map['created_at'] as String),
      );
}
