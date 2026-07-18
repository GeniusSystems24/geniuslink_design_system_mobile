import 'package:equatable/equatable.dart';

enum MdMarker { positive, warning, primary }
enum MdTone { success, information, warning, danger, neutral }
enum MdDirection { credit, debit }

class MdTrend extends Equatable {
  final bool up;
  final double pct;
  const MdTrend(this.up, this.pct);
  @override
  List<Object?> get props => [up, pct];
}

class MdCard extends Equatable {
  final String id;
  final String label;
  final MdMarker marker;
  final Map<String, double> values;
  final Map<String, MdTrend?> trends;
  final Map<String, List<double>> series;

  const MdCard({
    required this.id,
    required this.label,
    required this.marker,
    required this.values,
    required this.trends,
    required this.series,
  });

  @override
  List<Object?> get props => [id, label, marker, values, trends, series];
}

class MdAction extends Equatable {
  final String id;
  final String label;
  final String group;
  const MdAction(this.id, this.label, this.group);
  @override
  List<Object?> get props => [id, label, group];
}

class MdOperation extends Equatable {
  final String reference;
  final String type;
  final MdTone tone;
  final String description;
  final Map<String, double> amounts;
  final MdDirection direction;
  final String timeLabel;

  const MdOperation({
    required this.reference,
    required this.type,
    required this.tone,
    required this.description,
    required this.amounts,
    required this.direction,
    required this.timeLabel,
  });

  bool get isCredit => direction == MdDirection.credit;

  @override
  List<Object?> get props => [reference, type, tone, description, amounts, direction, timeLabel];
}

class MdAttention extends Equatable {
  final String id;
  final MdTone tone;
  final int count;
  final String label;
  final String description;
  const MdAttention(this.id, this.tone, this.count, this.label, this.description);
  @override
  List<Object?> get props => [id, tone, count, label, description];
}

class MdTab extends Equatable {
  final String id;
  final String label;
  final List<MdCard> cards;
  final List<MdAction> actions;
  final List<MdOperation> operations;
  const MdTab({required this.id, required this.label, required this.cards, required this.actions, required this.operations});
  @override
  List<Object?> get props => [id, label, cards, actions, operations];
}

class MdWorkspace extends Equatable {
  final String id;
  final String tenantId;
  final String name;
  final String subtitle;
  final double factor;
  const MdWorkspace(this.id, this.tenantId, this.name, this.subtitle, this.factor);
  @override
  List<Object?> get props => [id, tenantId, name, subtitle, factor];
}

class MdCurrency extends Equatable {
  final String code;
  final String name;
  const MdCurrency(this.code, this.name);
  @override
  List<Object?> get props => [code, name];
}


class MdStatusItem extends Equatable {
  final String id;
  final String label;
  final String value;
  final String description;
  final MdTone tone;

  const MdStatusItem({
    required this.id,
    required this.label,
    required this.value,
    required this.description,
    required this.tone,
  });

  @override
  List<Object?> get props => [id, label, value, description, tone];
}

class MdWorkflowItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final String value;
  final MdTone tone;

  const MdWorkflowItem({
    required this.id,
    required this.title,
    required this.description,
    required this.value,
    required this.tone,
  });

  @override
  List<Object?> get props => [id, title, description, value, tone];
}

class MdDashboardProfile extends Equatable {
  final String sectionId;
  final String eyebrow;
  final String title;
  final String subtitle;
  final String primaryActionId;
  final String primaryActionLabel;
  final String statusTitle;
  final String workflowTitle;
  final String workflowSubtitle;
  final String operationsTitle;
  final String attentionTitle;
  final List<MdStatusItem> statusItems;
  final List<MdWorkflowItem> workflowItems;
  final List<MdAttention> attentionItems;

  const MdDashboardProfile({
    required this.sectionId,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.primaryActionId,
    required this.primaryActionLabel,
    required this.statusTitle,
    required this.workflowTitle,
    required this.workflowSubtitle,
    required this.operationsTitle,
    required this.attentionTitle,
    required this.statusItems,
    required this.workflowItems,
    required this.attentionItems,
  });

  @override
  List<Object?> get props => [
        sectionId,
        eyebrow,
        title,
        subtitle,
        primaryActionId,
        primaryActionLabel,
        statusTitle,
        workflowTitle,
        workflowSubtitle,
        operationsTitle,
        attentionTitle,
        statusItems,
        workflowItems,
        attentionItems,
      ];
}

class MobileDashboardCatalog extends Equatable {
  final List<MdTab> tabs;
  final List<MdWorkspace> workspaces;
  final List<MdAttention> attention;
  final List<MdCurrency> currencies;
  final Map<String, List<String>> axisLabels;
  final Map<String, MdDashboardProfile> profiles;

  const MobileDashboardCatalog({
    required this.tabs,
    required this.workspaces,
    required this.attention,
    required this.currencies,
    required this.axisLabels,
    required this.profiles,
  });

  @override
  List<Object?> get props => [
        tabs,
        workspaces,
        attention,
        currencies,
        axisLabels,
        profiles,
      ];
}
