
import 'package:equatable/equatable.dart';

/// Authenticated control-plane user. Framework-free and reusable across UI,
/// application services, and repositories.
class AuthUser extends Equatable {
  final String id;
  final String name;
  final String email;

  const AuthUser({required this.id, required this.name, required this.email});

  static const empty = AuthUser(id: '', name: '', email: '');
  bool get isEmpty => this == empty;

  @override
  List<Object?> get props => [id, name, email];
}
