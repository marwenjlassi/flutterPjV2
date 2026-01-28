import 'package:equatable/equatable.dart';

/// User model for authentication
class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.createdAt,
  });

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Create a copy of UserModel with some fields updated
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phone,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, email, password, phone, createdAt];

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, createdAt: $createdAt)';
  }
}
