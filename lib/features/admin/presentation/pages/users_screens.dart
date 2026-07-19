// ============================================================
// VIEW — Users & Authentication (ports MobileUsers + Team)
// usersList (with session banner) · userDetail (full, 2FA + sessions)
// createUser · rolesPermissions
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gl_mobile_app/design_system/adapters/inventory/i_section.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/list_cubit.dart';
import '../../../../core/bloc/form_cubit.dart';
import '../../domain/domain.dart';

import '../widgets/widgets.dart';
export '../widgets/widgets.dart';
part 'users_list_screen.dart';
part 'user_detail_screen.dart';
part 'create_user_screen.dart';
part 'roles_permissions_screen.dart';

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
