import 'package:flutter/foundation.dart';

import '../../../core/state/load_status.dart';
import '../../../core/tenancy/tenant_connection.dart';
import '../../../core/tenancy/tenant_session.dart';

/// Immutable active-tenant state exposed by [TenantController].
class TenantState {
  final LoadStatus status;
  final List<TenantRef> availableTenants;
  final TenantSession? active;
  final String? error;

  const TenantState({
    this.status = LoadStatus.initial,
    this.availableTenants = const [],
    this.active,
    this.error,
  });

  String? get activeTenantId => active?.tenantId;

  TenantState copyWith({
    LoadStatus? status,
    List<TenantRef>? availableTenants,
    TenantSession? active,
    bool clearActive = false,
    String? error,
  }) {
    return TenantState(
      status: status ?? this.status,
      availableTenants: availableTenants ?? this.availableTenants,
      active: clearActive ? null : (active ?? this.active),
      error: error,
    );
  }
}

/// MVC controller for the database-per-tenant control-plane selection.
///
/// The application root owns this controller. A resolved active session is
/// consumed by TenantScope, whose ValueKey tears down the previous database
/// subtree whenever [activeTenantId] changes.
class TenantController extends ChangeNotifier {
  final TenantConnectionResolver resolver;

  int _switchGeneration = 0;
  bool _disposed = false;
  TenantState _state = const TenantState();

  TenantController({required this.resolver});

  TenantState get state => _state;

  void setAvailable(List<TenantRef> tenants) {
    _replace(_state.copyWith(availableTenants: tenants));
  }

  Future<void> loadAvailable() async {
    setAvailable(await resolver.availableTenants());
  }

  Future<void> switchTo(String tenantId) async {
    if (_state.activeTenantId == tenantId) return;
    final generation = ++_switchGeneration;
    _replace(_state.copyWith(status: LoadStatus.loading, error: null));
    try {
      final connection = await resolver.resolve(tenantId);
      if (_disposed || generation != _switchGeneration) return;
      final ref = _state.availableTenants.firstWhere(
        (tenant) => tenant.id == tenantId,
        orElse: () => TenantRef(id: tenantId, name: 'Tenant $tenantId'),
      );
      _replace(
        _state.copyWith(
          status: LoadStatus.ready,
          active: TenantSession.fromRef(ref, connection),
        ),
      );
    } catch (err) {
      if (_disposed || generation != _switchGeneration) return;
      _replace(
        _state.copyWith(status: LoadStatus.failure, error: err.toString()),
      );
    }
  }

  void clear() {
    _switchGeneration++;
    _replace(
      _state.copyWith(
        status: LoadStatus.initial,
        clearActive: true,
        error: null,
      ),
    );
  }

  void _replace(TenantState next) {
    if (_disposed) return;
    _state = next;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _switchGeneration++;
    super.dispose();
  }
}
