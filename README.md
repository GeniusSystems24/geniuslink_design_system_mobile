# GeniusLink Mobile — Full App (Flutter · Clean Architecture)

A Flutter port of the entire GeniusLink mobile app (`ui_kits/genius_link/mobile.html`):
auth, the four bottom tabs, and the 60+ sub-screens reachable from the **More**
menu. Dark-only (matches the web demo), bilingual EN/AR strings, and feature-first Clean Architecture.

## Input libraries

- `super_core` supplies the application `ThemeData`, tokens and shared visual foundation.
- `super_form_field` supplies standard text, numeric, date, select, attachment and boolean form fields.
- `super_auto_suggestion_box` remains the autocomplete/typeahead implementation for searchable master-data selectors, SKU entry and the global screen spotlight.


## Run
```bash
cd geniuslink_design_system_mobile
flutter pub get
flutter run        # device / emulator / -d chrome
```
Sign in on the login screen (any credentials — the button just enters the app).

## Project layout
```
lib/
  main.dart                      # MaterialApp (dark) → AppRoot
  controllers/
    nav_controller.dart          # CONTROLLER — auth gate · active tab · sub-screen stack
  views/
    app_root.dart                # navigator shell (auth → tabs → sub-stack)
    screen_registry.dart         # id → title/back (SUB_TITLES) + id → widget
    kit/                         # shared widget kit (ports window._mob / window._mui)
      super_core_theme_helpers.dart # opacity helpers; colors/type come from super_core
      m_icons.dart               #   icon-name → Material icon
      m_widgets.dart             #   Pill · MCard · MField · MBtn · Mini · Avatar · KV · MScroll · MTable (ReadableTable)
      m_inputs.dart              #   TInput · TPassword · TSelect · MSuggest (AutoSuggestionsBox) · TSwitch · TCheckbox · Segmented · SearchInput
      m_shell.dart               #   MAppBar · MTabBar
    screens/                     # VIEW — one file per feature area
      auth_screen.dart           #   login · signup · forgot
      dashboard_screen.dart      #   KPIs · cash-flow bars · balances · ops · alerts
      accounts_screens.dart      #   list · create · detail · group create · group detail
      stores_screens.dart        #   list · create · detail · issue inventory
      more_screen.dart           #   searchable module menu
```

## Porting status (batches)
The navigator is **complete** and every menu entry routes. Screens are ported
feature-area by feature-area; any not yet ported render a labelled placeholder
so the app stays runnable.

- **Batch 1 (done):** shared kit · navigation · Auth · Dashboard · Accounts (5) · Stores (4) · More menu
- **Batch 2 (done):** Ledger · Journal · Banking (deposit/withdrawal/local+external transfer)
- **Batch 3 (done):** Products & inventory ops (9) · inventory extras (dashboard, stock take, categories, UoM, price lists, barcode, warehouses, transfer list) · account tree + full account detail
- **Batch 4 (done):** Currencies (5) · Contacts (customers + suppliers, 6) · Reports (5) · Users (4)
- **Batch 5 (done):** Settings hub + Organization (6) · Team & Security (3) · Platform (6)

**Every screen in the navigator is now ported.** The `PendingScreen` placeholder remains only as a safety net for any unmapped id.

### Mobile Dashboard v2
A pixel-faithful rebuild of `Mobile Dashboard.html` lives at
`views/screens/mobile_dashboard_screen.dart` (+ `mobile_dashboard_data.dart`).
It renders full-bleed with its own chrome — workspace header, "Good morning",
domain tabs, view/currency/period row, metric cards, line-chart view with
breakdown bars, quick actions, recent operations, needs-attention, a search
FAB and bottom nav. Reachable from **More → Workspace → Mobile Dashboard**
(screen id `mobileDashboard`).

## Notes
- The app keeps **`geniuslink_design_system` v2.8.1** for legacy widgets while
  focused Super packages own the newer data-entry and data-view components.
  - **`super_tree_field` v1.0.0** — the **Account Tree** screen (`accountTree`)
    uses a typed `SuperTree<Account>` with `SuperTreeController<Account>` for
    search, expand/collapse, indent guides, leaf opening, and roll-up balances.
  - **`ReadableTable`** — wrapped as **`MTable`** (`m_widgets.dart`) for the
    genuinely tabular reports: **Trial Balance**, **Inventory Valuation** and the
    **Audit Log** now render in the DS grid with click-to-sort headers + TSV copy
    (keys derived from the cell text), and an opt-in quick-search bar
    (`showSearch`). Card-style lists stay as cards.
  - **`AutoSuggestionsBox`** — wrapped as **`MSuggest`** (`m_inputs.dart`, a
    strict-pick label+box; `mSuggestions([...])` builds plain rows). Used for the
    **Create Account** Parent-Group + Currency pickers, the **journal-line account
    picker** (combo · free text · grouped by account class), and the **More** menu
    is now a spotlight `AutoSuggestionsBox` over every screen (grouped, jump to
    open). Run `flutter pub get` after pulling so the path dependency resolves.
- Icons map to Material equivalents (the web kit drew inline SVG paths) — dependency-free.
- Fonts fall back to the platform UI font until the GL families are dropped into `assets/fonts/`.
- A separate single-screen project (`flutter_mobile_dashboard/`) ports the standalone
  "Mobile Dashboard" with light/dark + RTL; this project is the full multi-screen app.
```

## Presentation file structure

Each screen now lives in its own file under `lib/features/**/presentation/pages/`. Reusable feature widgets live under `lib/features/**/presentation/widgets/` and are exported through each feature's `widgets.dart` barrel. Existing `*_screens.dart` imports remain compatible and now act as feature page barrels.

## Reusing screens

All public screens are exported through a single application barrel:

```dart
import 'package:gl_mobile_app/screens.dart';
```

Every public `*Screen` widget exposes a public constructor with a named `key`
parameter. Feature-level imports are also available through
`features/<feature>/presentation/pages/pages.dart` and
`features/<feature>/presentation/presentation.dart`.

Contact screens accept the public `ContactKind` configuration so custom customer,
supplier, or partner variants can be embedded without depending on private types.

## Clean Architecture domain model

Business data used by screens is defined as immutable, framework-free entities
under `lib/features/<feature>/domain/entities/`. Examples include accounts,
users and permissions, contacts, currencies, products and stock movements,
journal entries, stores, settings catalogues, and both dashboard catalogues.

Demo and fixture values live under each feature's `data/datasources/` directory.
The application router is the composition root and injects the resulting domain
entities into reusable screen constructors. Presentation code does not import
feature data sources.

UI-only metadata, such as route identifiers and icon names, remains under
`presentation/models`; it is deliberately not part of the business domain.
Flutter form controllers also remain in Presentation and expose pure domain
entities at their boundary.

See [`docs/clean_architecture.md`](docs/clean_architecture.md) for the dependency
rules and run the architecture guard with:

```bash
python tool/check_clean_architecture.py
```
