
part of 'stores_screens.dart';

class StoresScreen extends StatelessWidget {
  final List<StoreSummary> stores;
  final ValueChanged<StoreSummary>? onStoreSelected;

  const StoresScreen({required this.stores, this.onStoreSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Stores'),
      body: MScroll([
        for (final store in stores)
          GestureDetector(
            onTap: () {
              final callback = onStoreSelected;
              if (callback != null) {
                callback(store);
              } else {
                context.goTo('storeDetail');
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(12)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(store.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                    if (store.localizedName case final localizedName?) ...[const SizedBox(height: 2), Directionality(textDirection: TextDirection.rtl, child: Text(localizedName, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)))],
                  ])),
                  Text(store.code, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                ]),
                Container(margin: const EdgeInsets.only(top: 14), padding: const EdgeInsets.only(top: 14), decoration: BoxDecoration(border: Border(top: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))), child: Row(children: [
                  _stat(context, 'Value', '${SuperFormat.number(store.stockValue, decimals: 0)} SAR'),
                  const SizedBox(width: 20),
                  _stat(context, 'SKUs', SuperFormat.number(store.skuCount, decimals: 0)),
                ])),
              ]),
            ),
          ),
      ]),
    );
  }

  Widget _stat(BuildContext context, String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Eyebrow(label, color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 9.5), const SizedBox(height: 3), Text(value, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 15, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1))]);
}
