
import '../../domain/domain.dart';

abstract final class MockSettingsDataSource {
  static const notificationCategories = <NotificationCategory>[
    NotificationCategory(id: 'ledger', title: 'Postings & Ledger', description: 'Entries posted, reversed'),
    NotificationCategory(id: 'approvals', title: 'Approvals', description: 'Wires & adjustments'),
    NotificationCategory(id: 'inventory', title: 'Inventory', description: 'Low stock, transfers'),
    NotificationCategory(id: 'security', title: 'Security', description: 'Sign-ins, key changes'),
    NotificationCategory(id: 'billing', title: 'Billing', description: 'Invoices & usage'),
  ];

  static const notificationChannels = <NotificationChannel>[NotificationChannel.email, NotificationChannel.inApp, NotificationChannel.sms];

  static const integrations = <IntegrationDefinition>[
    IntegrationDefinition(id: 'quickbooks', name: 'QuickBooks Online', description: 'Sync chart of accounts and journals', category: IntegrationCategory.accounting, connected: true),
    IntegrationDefinition(id: 'xero', name: 'Xero', description: 'Two-way accounting sync', category: IntegrationCategory.accounting),
    IntegrationDefinition(id: 'stripe', name: 'Stripe', description: 'Card payments and settlements', category: IntegrationCategory.payments, connected: true),
    IntegrationDefinition(id: 'moyasar', name: 'Moyasar', description: 'Saudi payment gateway', category: IntegrationCategory.payments),
    IntegrationDefinition(id: 'shopify', name: 'Shopify', description: 'Orders and inventory sync', category: IntegrationCategory.operations),
    IntegrationDefinition(id: 'slack', name: 'Slack', description: 'Operational notifications', category: IntegrationCategory.operations, connected: true),
  ];

  static const roleModules = <RoleModuleDefinition>[
    RoleModuleDefinition(id: 'accounts', name: 'Accounts'),
    RoleModuleDefinition(id: 'stores', name: 'Stores'),
    RoleModuleDefinition(id: 'inventory', name: 'Inventory'),
    RoleModuleDefinition(id: 'banking', name: 'Banking'),
    RoleModuleDefinition(id: 'ledger', name: 'Ledger'),
    RoleModuleDefinition(id: 'reports', name: 'Reports'),
    RoleModuleDefinition(id: 'customers', name: 'Customers'),
    RoleModuleDefinition(id: 'suppliers', name: 'Suppliers'),
    RoleModuleDefinition(id: 'users', name: 'Users'),
    RoleModuleDefinition(id: 'settings', name: 'Settings'),
  ];

  static const roleAccess = <String, RoleAccess>{
    'accounts': RoleAccess(canView: true, canEdit: true),
    'stores': RoleAccess(canView: true, canEdit: true),
    'inventory': RoleAccess(canView: true, canEdit: true, canDelete: true),
    'banking': RoleAccess(canView: true, canEdit: true),
    'ledger': RoleAccess(canView: true, canEdit: true),
    'reports': RoleAccess(canView: true),
    'customers': RoleAccess(canView: true, canEdit: true),
    'suppliers': RoleAccess(canView: true, canEdit: true),
    'users': RoleAccess(canView: true),
    'settings': RoleAccess(),
  };
}
