// ============================================================
// VIEW — Products & Inventory operations (ports MobileInventory)
// productsList · productDetail · createProduct · issueDetail
// receiveCreate · receiveDetail · transferCreate · transferDetail · adjustment
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_form_field/super_form_field.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});
  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  bool _force = false;
  String? _skuErr, _nameEnErr, _nameArErr;

  final _categoryCtl = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'Steel', 'Concrete', 'Lumber', 'Fasteners', 'Tools',
    ]),
    allowFreeText: false,
  );
  final _uomCtl = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'PCS', 'KG', 'TON', 'M', 'M²', 'LTR',
    ]),
    allowFreeText: false,
  );
  final _vatCtl = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      '0%', '5%', '15%',
    ]),
    allowFreeText: false,
    initialText: '15%',
  );
  final _storeCtl = AutoSuggestionsBoxController<String>(
    source: SuggestionSources.strings([
      'Downtown Central', 'North Warehouse', 'East Distribution',
    ]),
    allowFreeText: false,
  );

  @override
  void dispose() {
    _categoryCtl.dispose();
    _uomCtl.dispose();
    _vatCtl.dispose();
    _storeCtl.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _force = true);
    if (_skuErr == null && _nameEnErr == null && _nameArErr == null) {
      // TODO: persist product
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Create Product')),
      body: MScroll([
      ISection(
          icon: 'box',
          title: 'Product Definition',
          sub: 'SKU, names and classification',
          marker: M.blue,
          children: [
            SuperTextFormField(
              label: 'SKU',
              placeholder: 'e.g. STL-44021',
              required: true,
              minLength: 3,
              forceError: _force,
              onValidity: (e) => _skuErr = e,
            ),
            const SuperTextFormField(
              label: 'Barcode',
              placeholder: 'Scan or type',
              leadingIcon: Icons.qr_code_scanner_rounded,
            ),
            SuperTextFormField(
              label: 'Name English',
              placeholder: 'e.g. Structural Steel I-Beam',
              required: true,
              minLength: 2,
              forceError: _force,
              onValidity: (e) => _nameEnErr = e,
            ),
            SuperTextFormField(
              label: 'الاسم بالعربية',
              placeholder: 'مثال: كمرة فولاذية',
              arabic: true,
              required: true,
              minLength: 2,
              forceError: _force,
              onValidity: (e) => _nameArErr = e,
            ),
            AutoSuggestionsBox<String>(
              controller: _categoryCtl,
              label: 'Category',
              hintText: 'Select category…',
            ),
            AutoSuggestionsBox<String>(
              controller: _uomCtl,
              label: 'Unit of Measure',
              hintText: 'Select unit…',
            ),
          ]),
      ISection(
          icon: 'swap',
          title: 'Costing & Pricing',
          marker: M.green,
          children: [
            const SuperNumericFormField(
              label: 'Unit Cost (SAR)',
              prefix: 'SAR',
              decimals: 2,
              min: 0,
            ),
            const SuperNumericFormField(
              label: 'Selling Price (SAR)',
              prefix: 'SAR',
              decimals: 2,
              min: 0,
            ),
            AutoSuggestionsBox<String>(
              controller: _vatCtl,
              label: 'VAT Rate',
              hintText: 'Select rate…',
            ),
          ]),
      ISection(
          icon: 'store',
          title: 'Inventory Settings',
          marker: M.orange,
          children: [
            const SuperNumericFormField(
              label: 'Reorder Level',
              min: 0,
              step: 1,
              decimals: 0,
            ),
            AutoSuggestionsBox<String>(
              controller: _storeCtl,
              label: 'Default Store',
              hintText: 'Select store…',
            ),
            const SuperNumericFormField(
              label: 'Opening Stock',
              min: 0,
              step: 1,
              decimals: 0,
            ),
            SuperAttachmentFormField(
              label: 'Product Images',
              accept: '.jpg,.jpeg,.png,.pdf',
              maxSizeMB: 10,
              maxFiles: 5,
              multiple: true,
              onBrowse: () async => [],
            ),
          ]),
      ActionRow(primary: 'Create Product', onPrimary: _submit),
    ]),
    );
  }
}
