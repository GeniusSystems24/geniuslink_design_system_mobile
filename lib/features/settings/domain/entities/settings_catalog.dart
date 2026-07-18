
import 'package:equatable/equatable.dart';

enum NotificationChannel { email, inApp, sms }

enum IntegrationCategory { accounting, payments, operations }

class NotificationCategory extends Equatable {
  final String id;
  final String title;
  final String description;

  const NotificationCategory({required this.id, required this.title, required this.description});

  @override
  List<Object?> get props => [id, title, description];
}

class IntegrationDefinition extends Equatable {
  final String id;
  final String name;
  final String description;
  final IntegrationCategory category;
  final bool connected;

  const IntegrationDefinition({required this.id, required this.name, required this.description, required this.category, this.connected = false});

  @override
  List<Object?> get props => [id, name, description, category, connected];
}

class RoleModuleDefinition extends Equatable {
  final String id;
  final String name;

  const RoleModuleDefinition({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class RoleAccess extends Equatable {
  final bool canView;
  final bool canEdit;
  final bool canDelete;

  const RoleAccess({this.canView = false, this.canEdit = false, this.canDelete = false});

  List<bool> toList() => [canView, canEdit, canDelete];

  @override
  List<Object?> get props => [canView, canEdit, canDelete];
}
