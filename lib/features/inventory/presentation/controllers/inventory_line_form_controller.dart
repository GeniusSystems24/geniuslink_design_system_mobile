import 'package:super_form_field/super_form_field.dart';

import '../../domain/domain.dart';

/// Presentation-only adapter that owns the input controller while exposing a
/// framework-free [InventoryLine] to the application/domain boundary.
class InventoryLineFormController {
  final InventoryLine initialValue;
  final SuperNumericFieldController quantityController;

  InventoryLineFormController(InventoryLine line)
    : initialValue = line,
      quantityController = SuperNumericFieldController(
        initialValue: line.quantity,
      );

  String get sku => initialValue.sku;

  String get name => initialValue.name;

  InventoryLine get value => initialValue.copyWith(
    quantity: quantityController.value?.toDouble() ?? initialValue.quantity,
  );

  void dispose() => quantityController.dispose();
}
