class SettingsNavigationItem {
  final String routeId;
  final String label;
  final String iconName;
  final String description;

  const SettingsNavigationItem({
    required this.routeId,
    required this.label,
    required this.iconName,
    required this.description,
  });
}

class SettingsNavigationSection {
  final String title;
  final List<SettingsNavigationItem> items;
  const SettingsNavigationSection({required this.title, required this.items});
}

const defaultSettingsNavigation = <SettingsNavigationSection>[
  SettingsNavigationSection(
    title: 'Organization',
    items: [
      SettingsNavigationItem(
        routeId: 'setCompany',
        label: 'Company Profile',
        iconName: 'building',
        description: 'Legal name, logo, address, tax IDs',
      ),
      SettingsNavigationItem(
        routeId: 'setFinancial',
        label: 'Financial',
        iconName: 'globe',
        description: 'Base currency, fiscal year',
      ),
      SettingsNavigationItem(
        routeId: 'setTaxes',
        label: 'Taxes',
        iconName: 'percent',
        description: 'VAT / GST rules',
      ),
      SettingsNavigationItem(
        routeId: 'setCurrencies',
        label: 'Currencies',
        iconName: 'swap',
        description: 'Exchange rates',
      ),
      SettingsNavigationItem(
        routeId: 'setNumbering',
        label: 'Numbering',
        iconName: 'doc',
        description: 'Document prefixes',
      ),
      SettingsNavigationItem(
        routeId: 'setBranches',
        label: 'Branches & Stores',
        iconName: 'store',
        description: 'Locations & warehouses',
      ),
    ],
  ),
  SettingsNavigationSection(
    title: 'Workspace',
    items: [
      SettingsNavigationItem(
        routeId: 'tenants',
        label: 'Workspaces',
        iconName: 'switch2',
        description: 'Switch or manage organizations',
      ),
    ],
  ),
  SettingsNavigationSection(
    title: 'Team & Security',
    items: [
      SettingsNavigationItem(
        routeId: 'usersList',
        label: 'Users',
        iconName: 'user',
        description: 'Members & invites',
      ),
      SettingsNavigationItem(
        routeId: 'rolesList',
        label: 'Roles & Permissions',
        iconName: 'settings',
        description: 'Access per module',
      ),
      SettingsNavigationItem(
        routeId: 'auditLog',
        label: 'Audit Log',
        iconName: 'lock',
        description: 'Activity trail',
      ),
    ],
  ),
  SettingsNavigationSection(
    title: 'Platform',
    items: [
      SettingsNavigationItem(
        routeId: 'setIntegrations',
        label: 'Integrations',
        iconName: 'plug',
        description: 'Banking, e-commerce, email',
      ),
      SettingsNavigationItem(
        routeId: 'setWebhooks',
        label: 'Webhooks',
        iconName: 'link',
        description: 'Event subscriptions',
      ),
      SettingsNavigationItem(
        routeId: 'setApiKeys',
        label: 'API Keys',
        iconName: 'key',
        description: 'Access tokens',
      ),
      SettingsNavigationItem(
        routeId: 'setNotifications',
        label: 'Notifications',
        iconName: 'bell2',
        description: 'Email & in-app alerts',
      ),
      SettingsNavigationItem(
        routeId: 'setBilling',
        label: 'Billing & Plan',
        iconName: 'card',
        description: 'Subscription',
      ),
      SettingsNavigationItem(
        routeId: 'setBackup',
        label: 'Backup & Export',
        iconName: 'database',
        description: 'Export & snapshots',
      ),
    ],
  ),
];
