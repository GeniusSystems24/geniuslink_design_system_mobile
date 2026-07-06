import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';
import '../../../../design_system/kit.dart';

class _ProductLine {
  final String sku, name;
  final SuperNumericFieldController qtyCtl;
  _ProductLine(this.sku, this.name)
      : qtyCtl = SuperNumericFieldController(initialValue: 1);

  void dispose() => qtyCtl.dispose();
}

class TransferCreateScreen extends StatefulWidget {
  const TransferCreateScreen({super.key});
  @override
  State<TransferCreateScreen> createState() => _TransferCreateScreenState();
}

class _TransferCreateScreenState extends State<TransferCreateScreen> {
  final _fromCtl = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'Downtown Central',
      'North Warehouse',
      'East Distribution',
    ]),
    allowFreeText: false,
  );
  final _toCtl = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'North Warehouse',
      'Downtown Central',
      'East Distribution',
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
    _fromCtl.dispose();
    _toCtl.dispose();
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
    // TODO: persist transfer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Transfer Inventory')),
      body: MScroll([
      ISection(
          icon: 'box',
          title: 'Transfer Details',
          marker: M.blue,
          children: [
            const SuperTextFormField(
              label: 'Serial No',
              initialValue: 'INV-TRF-2024-0117',
              readOnly: true,
            ),
            AutoSuggestionsBox<String>(
              controller: _currencyCtl,
              label: 'Currency',
              hintText: 'Select currency…',
            ),
            AutoSuggestionsBox<String>(
              controller: _fromCtl,
              label: 'From Store',
              hintText: 'Search origin warehouse…',
            ),
            AutoSuggestionsBox<String>(
              controller: _toCtl,
              label: 'To Store',
              hintText: 'Search destination…',
            ),
          ]),
      ISection(
          icon: 'cart',
          title: 'Products',
          sub: '${_lines.length} line${_lines.length == 1 ? '' : 's'}',
          marker: M.blue,
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
      ISection(icon: 'doc', title: 'Notes & Docs', marker: M.orange, children: [
        const SuperTextFormField(
          label: 'Notes',
          placeholder: 'Enter transfer notes or internal instructions…',
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
      ActionRow(primary: 'Transfer Inventory', onPrimary: _submit),
    ]),
    );
  }
}
