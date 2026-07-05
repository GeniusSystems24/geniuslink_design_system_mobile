import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';
import '../../../../design_system/kit.dart';
import 'inventory_shared_widgets.dart';

class _BalancedRow extends StatelessWidget {
  final String value;
  const _BalancedRow({required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: M.borderStrong, width: 2))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Eyebrow('Balanced · Diff 0.00', color: M.green, size: 11),
        Text(value,
            style: const TextStyle(
                fontFamily: M.mono,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: M.fg1)),
      ]),
    );
  }
}

class _ProductLine {
  final String sku, name;
  final SuperNumericFieldController qtyCtl;
  _ProductLine(this.sku, this.name)
      : qtyCtl = SuperNumericFieldController(initialValue: 1);

  void dispose() => qtyCtl.dispose();
}

class ReceiveCreateScreen extends StatefulWidget {
  const ReceiveCreateScreen({super.key});
  @override
  State<ReceiveCreateScreen> createState() => _ReceiveCreateScreenState();
}

class _ReceiveCreateScreenState extends State<ReceiveCreateScreen> {
  final _storeCtl = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'Downtown Central',
      'North Warehouse',
      'East Distribution',
    ]),
    allowFreeText: false,
  );
  final _supplierCtl = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'ABC Trading Co.',
      'SteelMart LLC',
      'ConcretePro Ltd.',
    ]),
    allowFreeText: false,
  );
  final _currencyCtl = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'SAR — Saudi Riyal',
      'USD — US Dollar',
      'EUR — Euro',
    ]),
    allowFreeText: false,
  );
  final _lines = <_ProductLine>[];

  @override
  void dispose() {
    for (final l in _lines) { l.dispose(); }
    _storeCtl.dispose();
    _supplierCtl.dispose();
    _currencyCtl.dispose();
    super.dispose();
  }

  void _addLine(String raw) {
    final parts = raw.split(' — ');
    final sku = parts.isNotEmpty ? parts[0] : raw;
    final name = parts.length > 1 ? parts[1] : raw;
    setState(() => _lines.insert(0, _ProductLine(sku, name)));
  }

  void _submit() {
    // TODO: persist receive
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Receive Inventory')),
      body: MScroll([
      ISection(
          icon: 'box',
          title: 'Receive Details',
          marker: M.blue,
          children: [
            SuperTextFormField(
              label: 'Serial No',
              initialValue: 'INV-REC-2024-0241',
              readOnly: true,
            ),
            AutoSuggestionsBox<String>(
              controller: _currencyCtl,
              label: 'Currency',
              hintText: 'Select currency…',
            ),
            AutoSuggestionsBox<String>(
              controller: _storeCtl,
              label: 'Receiving Store',
              hintText: 'Search store…',
            ),
            AutoSuggestionsBox<String>(
              controller: _supplierCtl,
              label: 'Supplier Account',
              hintText: 'e.g. ABC Trading Co.',
            ),
          ]),
      ISection(
          icon: 'cart',
          title: 'Inventory Items',
          sub: '${_lines.length} line${_lines.length == 1 ? '' : 's'} · received into stock',
          marker: M.green,
          children: [
            Scanner(onPick: _addLine),
            ..._lines.asMap().entries.map((e) {
              final i = e.key;
              final l = e.value;
              return ProductRow(
                name: l.name,
                sku: l.sku,
                qtyController: l.qtyCtl,
                price: '—',
                total: '—',
                currency: '',
                last: i == _lines.length - 1,
              );
            }),
            const AddProductBtn(),
          ]),
      const ISection(
          icon: 'swap',
          title: 'Accounting Distribution',
          marker: M.green,
          children: [
            DistRow(
                account: '1200 — Inventory (WIP)',
                side: 'Debit',
                amount: '+24,200.00',
                last: false),
            DistRow(
                account: '2001 — Accounts Payable',
                side: 'Credit',
                amount: '-24,200.00',
                last: true),
            _BalancedRow(value: '24,200.00'),
          ]),
      ISection(icon: 'doc', title: 'Notes & Docs', marker: M.orange, children: [
        SuperTextFormField(
          label: 'Receipt Notes',
          placeholder: 'PO number, delivery note, inspection results…',
          multiline: true,
          rows: 3,
        ),
        SuperAttachmentFormField(
          label: 'Attachments',
          accept: '.pdf,.jpg,.jpeg,.png',
          maxSizeMB: 10,
          maxFiles: 5,
          multiple: true,
          onBrowse: () async => [],
        ),
      ]),
      ActionRow(primary: 'Receive Inventory', onPrimary: _submit),
    ]),
    );
  }
}
