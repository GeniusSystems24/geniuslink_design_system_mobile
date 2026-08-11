import '../../domain/domain.dart';

abstract final class MockInventoryDataSource {
  static const products = <ProductSummary>[
    ProductSummary(
      sku: 'STL-44021',
      name: 'Structural Steel I-Beam',
      category: 'Steel',
      unit: 'PCS',
      onHand: 142,
      status: InventoryStockStatus.inStock,
    ),
    ProductSummary(
      sku: 'CMT-90112',
      name: 'Portland Cement Type I',
      category: 'Cement',
      unit: 'BAG',
      onHand: 1820,
      status: InventoryStockStatus.inStock,
    ),
    ProductSummary(
      sku: 'AGG-21044',
      name: 'Coarse Aggregate 20mm',
      category: 'Aggregate',
      unit: 'TON',
      onHand: 46,
      status: InventoryStockStatus.lowStock,
    ),
    ProductSummary(
      sku: 'RBR-71203',
      name: 'Reinforcement Bar #6',
      category: 'Steel',
      unit: 'PCS',
      onHand: 0,
      status: InventoryStockStatus.outOfStock,
    ),
    ProductSummary(
      sku: 'PLY-30022',
      name: 'Plywood Sheet 18mm',
      category: 'Timber',
      unit: 'SHT',
      onHand: 312,
      status: InventoryStockStatus.inStock,
    ),
    ProductSummary(
      sku: 'PNT-55310',
      name: 'Epoxy Floor Coating',
      category: 'Finishing',
      unit: 'L',
      onHand: 88,
      status: InventoryStockStatus.inStock,
    ),
  ];

  static final productDetail = ProductDetail(
    product: products.first,
    barcode: '6 281000 044021',
    averageUnitCost: 450,
    sellingPrice: 540,
    reorderLevel: 50,
    vatRate: 0.15,
    stockByStore: const [
      StoreStockBalance(
        storeCode: 'ST-001',
        storeName: 'Downtown Central',
        quantity: 88,
        value: 39600,
      ),
      StoreStockBalance(
        storeCode: 'ST-002',
        storeName: 'King Fahd Warehouse',
        quantity: 42,
        value: 18900,
      ),
      StoreStockBalance(
        storeCode: 'ST-003',
        storeName: 'Jeddah Showroom',
        quantity: 12,
        value: 5400,
      ),
    ],
    recentMovements: [
      InventoryMovement(
        reference: 'INV-ISS-0089',
        type: InventoryMovementType.issue,
        quantityDelta: -12,
        occurredAt: DateTime(2025, 12, 18),
      ),
      InventoryMovement(
        reference: 'INV-REC-0241',
        type: InventoryMovementType.receive,
        quantityDelta: 32,
        occurredAt: DateTime(2025, 12, 16),
      ),
      InventoryMovement(
        reference: 'INV-TRF-0117',
        type: InventoryMovementType.transfer,
        quantityDelta: 18,
        occurredAt: DateTime(2025, 12, 14),
      ),
    ],
  );
}
