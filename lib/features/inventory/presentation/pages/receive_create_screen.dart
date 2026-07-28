import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/adapters/inventory/i_section.dart';
import 'package:super_form_field/super_form_field.dart';
import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import '../controllers/inventory_line_form_controller.dart';
import 'inventory_shared_widgets.dart';

class _BalancedRow extends StatelessWidget {
  final String value;
  const _BalancedRow({required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: SuperMaterialThemeData.of(context).superTheme.borderStrong,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Eyebrow(
            'Balanced · Diff 0.00',
            color: SuperMaterialThemeData.of(context).colorScheme.secondary,
            size: 11,
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: SuperMaterialThemeData.of(
                context,
              ).textTheme.bodyMedium?.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: SuperMaterialThemeData.of(context).superTheme.fg1,
            ),
          ),
        ],
      ),
    );
  }
}

class ReceiveCreateScreen extends StatefulWidget {
  final Future<void> Function(List<InventoryLine> lines)? onSubmit;

  const ReceiveCreateScreen({this.onSubmit, super.key});
  @override
  State<ReceiveCreateScreen> createState() => _ReceiveCreateScreenState();
}

class _ReceiveCreateScreenState extends State<ReceiveCreateScreen> {
  final _storeController = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'Downtown Central',
      'North Warehouse',
      'East Distribution',
    ]),
    allowFreeText: false,
  );
  final _supplierController = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'ABC Trading Co.',
      'SteelMart LLC',
      'ConcretePro Ltd.',
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
    _storeController.dispose();
    _supplierController.dispose();
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
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Receive Inventory')),
      body: MScroll([
        ISection(
          icon: MIcons.of('box'),
          title: 'Receive Details',
          marker: SuperMaterialThemeData.of(context).colorScheme.primary,
          children: [
            const SuperTextFormField(
              decoration: InputDecoration(labelText: 'Serial No'),
              initialValue: 'INV-REC-2024-0241',
              readOnly: true,
            ),
            AutoSuggestionsBox<String>(
              controller: _currencyController,
              label: 'Currency',
              hintText: 'Select currency…',
            ),
            AutoSuggestionsBox<String>(
              controller: _storeController,
              label: 'Receiving Store',
              hintText: 'Search store…',
            ),
            AutoSuggestionsBox<String>(
              controller: _supplierController,
              label: 'Supplier Account',
              hintText: 'e.g. ABC Trading Co.',
            ),
          ],
        ),
        ISection(
          icon: MIcons.of('cart'),
          title: 'Inventory Items',
          sub:
              '${_lines.length} line${_lines.length == 1 ? '' : 's'} · received into stock',
          marker: SuperMaterialThemeData.of(context).colorScheme.secondary,
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
        ISection(
          icon: MIcons.of('swap'),
          title: 'Accounting Distribution',
          marker: SuperMaterialThemeData.of(context).colorScheme.secondary,
          children: const [
            DistRow(
              account: '1200 — Inventory (WIP)',
              side: 'Debit',
              amount: '+24,200.00',
              last: false,
            ),
            DistRow(
              account: '2001 — Accounts Payable',
              side: 'Credit',
              amount: '-24,200.00',
              last: true,
            ),
            _BalancedRow(value: '24,200.00'),
          ],
        ),
        ISection(
          icon: MIcons.of('doc'),
          title: 'Notes & Docs',
          marker: SuperMaterialThemeData.of(context).colorScheme.tertiary,
          children: [
            const SuperTextFormField(
              decoration: InputDecoration(
                labelText: 'Receipt Notes',
                hintText: 'PO number, delivery note, inspection results…',
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
        ActionRow(primary: 'Receive Inventory', onPrimary: _submit),
      ]),
    );
  }
}
