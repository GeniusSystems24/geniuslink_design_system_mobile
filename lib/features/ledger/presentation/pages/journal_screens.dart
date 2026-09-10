// ============================================================
// VIEW — Journal feature (ports MobileJournal)
// journalList · createJournalEntry · journalEntryDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';

import '../widgets/widgets.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';
export '../widgets/widgets.dart';
part 'journal_list_screen.dart';
part 'create_journal_entry_screen.dart';
part 'journal_entry_detail_screen.dart';

part '../widgets/page_views/create_journal_entry_screen_view.dart';
part '../widgets/page_views/journal_entry_detail_screen_view.dart';
part '../widgets/page_views/journal_list_screen_view.dart';