import 'package:equatable/equatable.dart';

enum UserAccountStatus {
  active,
  inactive,
  pending;

  String get label => name;
}

class UserSummary extends Equatable {
  final int id;
  final String name;
  final String email;
  final String role;
  final UserAccountStatus status;

  const UserSummary({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name, email, role, status];
}
