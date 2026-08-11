part of 'stores_screens.dart';

class StoreDetailScreen extends StatelessWidget {
  final StoreSummary store;

  const StoreDetailScreen({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    var trailing = Pill(
      store.active ? 'Active' : 'Inactive',
      tone: store.active ? PillTone.success : PillTone.neutral,
    );
    var title = store.name;
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Store Detail')),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: title,
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: null,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Mini(
                      label: 'Stock Value',
                      value: SuperFormat.number(store.stockValue, decimals: 0),
                      sub: 'SAR',
                      hi: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Mini(
                      label: 'SKUs',
                      value: SuperFormat.number(store.skuCount, decimals: 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Stock On Hand',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: null,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < store.stockItems.length; i++)
                      _stockRow(
                        context,
                        store.stockItems[i],
                        i == store.stockItems.length - 1,
                      ),
                    if (store.stockItems.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'No stock items available.',
                          style: TextStyle(
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg3,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MBtn(
          'Back to List',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('stores'),
        ),
      ]),
    );
  }

  Widget _stockRow(BuildContext context, StoreStockItem item, bool last) {
    final qtyColor = switch (item.status) {
      StoreStockStatus.outOfStock => SuperMaterialThemeData.of(
        context,
      ).colorScheme.error,
      StoreStockStatus.lowStock => SuperMaterialThemeData.of(
        context,
      ).colorScheme.tertiary,
      StoreStockStatus.inStock => SuperMaterialThemeData.of(
        context,
      ).superTheme.fg1,
    };
    final tone = switch (item.status) {
      StoreStockStatus.inStock => PillTone.success,
      StoreStockStatus.lowStock => PillTone.warning,
      StoreStockStatus.outOfStock => PillTone.danger,
    };
    final label = switch (item.status) {
      StoreStockStatus.inStock => 'In',
      StoreStockStatus.lowStock => 'Low',
      StoreStockStatus.outOfStock => 'Out',
    };
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(
                bottom: BorderSide(
                  color: SuperMaterialThemeData.of(context).superTheme.border,
                ),
              ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: SuperMaterialThemeData.of(context).superTheme.fg1,
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.sku,
                  style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                    fontSize: 11,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${item.quantity}',
            style: TextStyle(
              fontFamily: SuperMaterialThemeData.of(
                context,
              ).textTheme.bodyMedium?.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: qtyColor,
            ),
          ),
          const SizedBox(width: 12),
          Pill(label, tone: tone),
        ],
      ),
    );
  }
}
