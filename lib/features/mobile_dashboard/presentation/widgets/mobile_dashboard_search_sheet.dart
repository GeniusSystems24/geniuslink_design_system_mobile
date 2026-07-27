import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardSearchSheet extends StatefulWidget {
  final String currency;
  final double factor;
  final List<MdTab> tabs;
  final ValueChanged<MdOperation>? onOperationTap;

  const MobileDashboardSearchSheet({
    required this.currency,
    required this.factor,
    required this.tabs,
    this.onOperationTap,
    super.key,
  });

  @override
  State<MobileDashboardSearchSheet> createState() =>
      _MobileDashboardSearchSheetState();
}

class _MobileDashboardSearchSheetState
    extends State<MobileDashboardSearchSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = context.mdTheme;
    final allOperations = [
      for (final tab in widget.tabs)
        for (final operation in tab.operations) (operation, tab.label),
    ];
    final normalizedQuery = _query.trim().toLowerCase();
    final results = normalizedQuery.isEmpty
        ? allOperations
        : allOperations
            .where(
              (entry) =>
                  '${entry.$1.reference} ${entry.$1.description} ${entry.$1.type}'
                      .toLowerCase()
                      .contains(normalizedQuery),
            )
            .toList(growable: false);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.inputBg,
                      border: Border.all(color: theme.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      MIcons.of('back'),
                      size: 18,
                      color: theme.fg1,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SuperTextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Search all operations…',
                      prefixIcon: Icon(Icons.search_rounded, size: 18),
                    ),
                    clearable: true,
                    density: FieldDensity.compact,
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.border),
          Flexible(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    _query.trim().isEmpty
                        ? 'SEARCH ACROSS BANKING, ACCOUNTING & COMMERCIAL'
                        : 'RESULTS · ${results.length}',
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      letterSpacing: 0.9,
                      color: theme.fg3,
                    ),
                  ),
                ),
                if (results.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        'No matching operations',
                        style: TextStyle(
                          color: theme.fg2,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily:
                              context.mdTextTheme.bodyMedium?.fontFamily,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: theme.surface,
                      border: Border.all(color: theme.border),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        for (var index = 0;
                            index < results.length;
                            index++)
                          MobileDashboardSearchResultRow(
                            operation: results[index].$1,
                            domain: results[index].$2,
                            currency: widget.currency,
                            factor: widget.factor,
                            last: index == results.length - 1,
                            onTap: widget.onOperationTap == null
                                ? null
                                : () => widget.onOperationTap!(
                                      results[index].$1,
                                    ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MobileDashboardSearchResultRow extends StatelessWidget {
  final MdOperation operation;
  final String domain;
  final String currency;
  final double factor;
  final bool last;
  final VoidCallback? onTap;

  const MobileDashboardSearchResultRow({
    required this.operation,
    required this.domain,
    required this.currency,
    required this.factor,
    required this.last,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.mdTheme;
    final amountColor = operation.isCredit
        ? context.mdColors.secondary
        : context.mdColors.error;
    final sign = operation.isCredit ? '+' : '−';
    final amount = (operation.amounts[currency] ?? 0) * factor;
    final content = Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(bottom: BorderSide(color: theme.border)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  operation.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.fg1,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$sign$currency ${mobileDashboardNumber(amount, decimals: 2)}',
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: amountColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Text(
                operation.reference,
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 11,
                  color: context.mdColors.primary,
                ),
              ),
              const Spacer(),
              Text(
                domain.toUpperCase(),
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  color: theme.fg3,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return InkWell(onTap: onTap, child: content);
  }
}
