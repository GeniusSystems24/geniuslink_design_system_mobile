import '../../domain/domain.dart';

abstract final class MockAdminDataSource {
  static const users = <UserSummary>[
    UserSummary(
      id: 5,
      name: 'Admin User',
      email: 'admin@geniuslink.sa',
      role: 'Administrator',
      status: UserAccountStatus.active,
    ),
    UserSummary(
      id: 12,
      name: 'Layla Ahmed',
      email: 'layla.a@geniuslink.sa',
      role: 'Accountant',
      status: UserAccountStatus.active,
    ),
    UserSummary(
      id: 3,
      name: 'Controller',
      email: 'controller@geniuslink.sa',
      role: 'Controller',
      status: UserAccountStatus.active,
    ),
    UserSummary(
      id: 21,
      name: 'Khalid Saleh',
      email: 'khalid.s@geniuslink.sa',
      role: 'Store Manager',
      status: UserAccountStatus.active,
    ),
    UserSummary(
      id: 33,
      name: 'Noura Faisal',
      email: 'noura.f@geniuslink.sa',
      role: 'Viewer',
      status: UserAccountStatus.inactive,
    ),
    UserSummary(
      id: 41,
      name: 'Omar Hassan',
      email: 'omar.h@geniuslink.sa',
      role: 'Accountant',
      status: UserAccountStatus.pending,
    ),
  ];
}
