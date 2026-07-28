import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';
import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import '../controllers/inventory_line_form_controller.dart';

class TransferCreateScreen extends StatefulWidget {
  final Future<void> Function(List<InventoryLine> lines)? onSubmit;

  const TransferCreateScreen({this.onSubmit, super.key});
  @override
  State<TransferCreateScreen> createState() => _TransferCreateScreenState();
}

class _TransferCreateScreenState extends State<TransferCreateScreen> {
  final _fromController = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'Downtown Central',
      'North Warehouse',
      'East Distribution',
    ]),
    allowFreeText: false,
  );
  final _toController = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'North Warehouse',
      'Downtown Central',
      'East Distribution',
    ]),
    allowFreeText: false,
  );
  final _currencyController = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'SAR — Saudi Riyal',
      'USD — US Dollar',
      'EUR — Euro',
    ]),
    allowFreeText: false,
  );
  final _lines = <InventoryLineFormController>[];

  @override
  void dispose() {
    for (final l in _lines) {
      l.dispose();
    }
    _fromController.dispose();
    _toController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  void _addLine(String raw) {
    final parts = raw.split(' — ');
    final sku = parts.isNotEmpty ? parts[0] : raw;
    final name = parts.length > 1 ? parts[1] : raw;
    setState(
      () => _lines.insert(
        0,
        InventoryLineFormController(InventoryLine(sku: sku, name: name)),
      ),
    );
  }

  Future<void> _submit() async {
    await widget.onSubmit?.call(
      _lines.map((line) => line.value).toList(growable: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    var marker = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon = MIcons.of('doc');
    var marker2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('cart');
    var marker3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon3 = MIcons.of('box');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Transfer Inventory')),
      body: MScroll([
        SuperSectionCard2(
      trailing: (null),
      title: 'Transfer Details',
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: marker3,
      icon: icon3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
              const SuperTextFormField(
                decoration: InputDecoration(labelText: 'Serial No'),
                initialValue: 'INV-TRF-2024-0117',
                readOnly: true,
              ),
              AutoSuggestionsBox<String>(
                controller: _currencyController,
                label: 'Currency',
                hintText: 'Select currency…',
              ),
              AutoSuggestionsBox<String>(
                controller: _fromController,
                label: 'From Store',
                hintText: 'Search origin warehouse…',
              ),
              AutoSuggestionsBox<String>(
                controller: _toController,
                label: 'To Store',
                hintText: 'Search destination…',
              ),
            ],
      ),
    ),
        SuperSectionCard2(
      trailing: (null),
      title: 'Products',
      subtitle: '${_lines.length} line${_lines.length == 1 ? '' : 's'}',
      initiallyExpanded: true,
      accentColor: marker2,
      icon: icon2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
              Scanner(onPick: _addLine),
              ..._lines.asMap().entries.map((e) {
                final i = e.key;
                final l = e.value;
                return ProductRow(
                  name: l.name,
                  sku: l.sku,
                  qtyController: l.quantityController,
                  price: '—',
                  total: '—',
                  currency: '',
                  last: i == _lines.length - 1,
                );
              }),
              const AddProductBtn(),
            ],
      ),
    ),
        SuperSectionCard2(
      trailing: (null),
      title: 'Notes & Docs',
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: marker,
      icon: icon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
              const SuperTextFormField(
                decoration: InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Enter transfer notes or internal instructions…',
                ),
                multiline: true,
                rows: 3,
              ),
              SuperAttachmentFormField(
                decoration: const InputDecoration(labelText: 'Attachments'),
                accept: '.pdf,.jpg,.jpeg,.png',
                maxSizeMB: 10,
                maxFiles: 5,
                multiple: true,
                onBrowse: () async => const <SuperFile>[],
              ),
            ],
      ),
    ),
        ActionRow(primary: 'Transfer Inventory', onPrimary: _submit),
      ]),
    );
  }
}
