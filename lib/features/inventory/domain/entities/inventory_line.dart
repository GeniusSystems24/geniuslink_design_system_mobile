import 'package:equatable/equatable.dart';

class InventoryLine extends Equatable {
  final String sku;
  final String name;
  final double quantity;

  const InventoryLine({required this.sku, required this.name, this.quantity = 1});

  InventoryLine copyWith({String? sku, String? name, double? quantity}) => InventoryLine(
        sku: sku ?? this.sku,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
      );

  @override
  List<Object?> get props => [sku, name, quantity];
}
