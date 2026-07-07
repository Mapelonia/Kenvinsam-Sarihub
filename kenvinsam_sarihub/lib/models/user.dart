class User {
  final int? id;
  final String username;
  final String password;
  final String role;
  final String? displayName;
  final DateTime createdAt;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.role,
    this.displayName,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
      'display_name': displayName,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
      displayName: map['display_name'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? role,
    String? displayName,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isAdmin => role == 'admin';
}
