import '../../domain/domain.dart';

abstract final class MockStoresDataSource {
  static const stores = <StoreSummary>[
    StoreSummary(
      code: 'ST-001',
      name: 'Downtown Central',
      localizedName: 'وسط المدينة',
      stockValue: 342820,
      skuCount: 1248,
      stockItems: [
        StoreStockItem(
          sku: 'STL-44021',
          name: 'Steel I-Beam',
          quantity: 142,
          status: StoreStockStatus.inStock,
        ),
        StoreStockItem(
          sku: 'AGG-21044',
          name: 'Aggregate 20mm',
          quantity: 46,
          status: StoreStockStatus.lowStock,
        ),
        StoreStockItem(
          sku: 'RBR-71203',
          name: 'Rebar #6',
          quantity: 0,
          status: StoreStockStatus.outOfStock,
        ),
      ],
    ),
    StoreSummary(
      code: 'ST-002',
      name: 'King Fahd Warehouse',
      localizedName: 'مستودع الملك فهد',
      stockValue: 1820460,
      skuCount: 4892,
    ),
    StoreSummary(
      code: 'ST-003',
      name: 'Jeddah Showroom',
      localizedName: 'صالة عرض جدة',
      stockValue: 128640,
      skuCount: 412,
    ),
  ];
}
