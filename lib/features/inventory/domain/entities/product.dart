
import 'package:equatable/equatable.dart';

enum InventoryStockStatus { inStock, lowStock, outOfStock }
enum InventoryMovementType { issue, receive, transfer, adjustment }

class ProductSummary extends Equatable {
  final String sku;
  final String name;
  final String category;
  final String unit;
  final int onHand;
  final InventoryStockStatus status;

  const ProductSummary({required this.sku, required this.name, required this.category, required this.unit, required this.onHand, required this.status});

  @override
  List<Object?> get props => [sku, name, category, unit, onHand, status];
}

class StoreStockBalance extends Equatable {
  final String storeCode;
  final String storeName;
  final int quantity;
  final double value;

  const StoreStockBalance({required this.storeCode, required this.storeName, required this.quantity, required this.value});

  @override
  List<Object?> get props => [storeCode, storeName, quantity, value];
}

class InventoryMovement extends Equatable {
  final String reference;
  final InventoryMovementType type;
  final int quantityDelta;
  final DateTime occurredAt;

  const InventoryMovement({required this.reference, required this.type, required this.quantityDelta, required this.occurredAt});

  @override
  List<Object?> get props => [reference, type, quantityDelta, occurredAt];
}

class ProductDetail extends Equatable {
  final ProductSummary product;
  final String barcode;
  final double averageUnitCost;
  final double sellingPrice;
  final int reorderLevel;
  final double vatRate;
  final List<StoreStockBalance> stockByStore;
  final List<InventoryMovement> recentMovements;

  const ProductDetail({required this.product, required this.barcode, required this.averageUnitCost, required this.sellingPrice, required this.reorderLevel, required this.vatRate, this.stockByStore = const [], this.recentMovements = const []});

  int get totalOnHand => stockByStore.fold<int>(0, (sum, item) => sum + item.quantity);
  double get stockValue => stockByStore.fold<double>(0, (sum, item) => sum + item.value);

  @override
  List<Object?> get props => [product, barcode, averageUnitCost, sellingPrice, reorderLevel, vatRate, stockByStore, recentMovements];
}
