// lib/data/models/auth/user_model.dart
import 'package:them/domain/entities/auth/user_entity.dart';

/// Model cho dữ liệu người dùng từ API
class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
    String? profilePicture,
  }) : super(
          id: id,
          name: name,
          email: email,
          profilePicture: profilePicture,
        );

  /// Tạo UserModel từ JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
    );
  }

  /// Chuyển UserModel thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_picture': profilePicture,
    };
  }
}