
import 'package:equatable/equatable.dart';

enum StoreStockStatus { inStock, lowStock, outOfStock }

class StoreStockItem extends Equatable {
  final String sku;
  final String name;
  final int quantity;
  final StoreStockStatus status;

  const StoreStockItem({required this.sku, required this.name, required this.quantity, required this.status});

  @override
  List<Object?> get props => [sku, name, quantity, status];
}

class StoreSummary extends Equatable {
  final String code;
  final String name;
  final String? localizedName;
  final double stockValue;
  final int skuCount;
  final bool active;
  final List<StoreStockItem> stockItems;

  const StoreSummary({required this.code, required this.name, required this.stockValue, required this.skuCount, this.localizedName, this.active = true, this.stockItems = const []});

  @override
  List<Object?> get props => [code, name, localizedName, stockValue, skuCount, active, stockItems];
}
