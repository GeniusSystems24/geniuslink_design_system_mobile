import 'package:flutter/material.dart';

import 'accounts_shared_components.dart';

/// Screen-level visual overrides for the create-account screen.
@immutable
class CreateAccountScreenThemeData {
  const CreateAccountScreenThemeData({
    this.backgroundColor,
    this.detailsAccentColor,
    this.settingsAccentColor,
    this.section = const AccountsSectionThemeData(),
    this.actions = const AccountsPageActionsThemeData(),
    this.normalBalanceChoice = const AccountsChoicePairThemeData(),
  });

  final Color? backgroundColor;
  final Color? detailsAccentColor;
  final Color? settingsAccentColor;
  final AccountsSectionThemeData section;
  final AccountsPageActionsThemeData actions;
  final AccountsChoicePairThemeData normalBalanceChoice;
}

/// Screen-level visual overrides for the create-group screen.
@immutable
class CreateGroupScreenThemeData {
  const CreateGroupScreenThemeData({
    this.backgroundColor,
    this.detailsAccentColor,
    this.additionalInformationAccentColor,
    this.section = const AccountsSectionThemeData(),
    this.actions = const AccountsPageActionsThemeData(),
  });

  final Color? backgroundColor;
  final Color? detailsAccentColor;
  final Color? additionalInformationAccentColor;
  final AccountsSectionThemeData section;
  final AccountsPageActionsThemeData actions;
}

/// Screen-level visual overrides for the group-detail screen.
@immutable
class GroupDetailScreenThemeData {
  const GroupDetailScreenThemeData({
    this.backgroundColor,
    this.informationAccentColor,
    this.notesAccentColor,
    this.auditAccentColor,
    this.section = const AccountsSectionThemeData(),
    this.note = const AccountsNoteSurfaceThemeData(),
  });

  final Color? backgroundColor;
  final Color? informationAccentColor;
  final Color? notesAccentColor;
  final Color? auditAccentColor;
  final AccountsSectionThemeData section;
  final AccountsNoteSurfaceThemeData note;
}
