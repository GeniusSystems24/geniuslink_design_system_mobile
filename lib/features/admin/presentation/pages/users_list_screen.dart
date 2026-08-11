import 'package:flutter/material.dart';

import '../../../../shared/presentation/controllers/list_controller.dart';
import '../../domain/domain.dart';
import '../widgets/users_list_view.dart';

bool userPredicate(
  UserSummary user,
  String query,
  Map<String, Object?> filters,
) {
  final role = (filters['role'] as String?) ?? 'All';
  if (role != 'All' && user.role != role) return false;
  final normalized = query.trim().toLowerCase();
  return normalized.isEmpty ||
      user.name.toLowerCase().contains(normalized) ||
      user.email.toLowerCase().contains(normalized);
}

class UsersListScreen extends StatefulWidget {
  final List<UserSummary> users;

  const UsersListScreen({required this.users, super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late final ListController<UserSummary> _controller;

  @override
  void initState() {
    super.initState();
    _controller = ListController<UserSummary>(
      source: () => widget.users,
      predicate: userPredicate,
      initialFilters: const {'role': 'All'},
    );
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => UsersListView(controller: _controller);
}
