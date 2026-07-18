# GeniusLink Mobile — Full App (Flutter · MVC)

A Flutter port of the entire GeniusLink mobile app (`ui_kits/genius_link/mobile.html`):
auth, the four bottom tabs, and the 60+ sub-screens reachable from the **More**
menu. Dark-only (matches the web demo), bilingual EN/AR strings, MVC structure.

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

## MVC layout
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
- The app uses the focused GeniusLink packages directly:
  - **`super_core`** for the complete Material theme and shared tokens.
  - **`super_form_field`** for standard text, numeric, date, select, attachment,
    boolean and choice fields.
  - **`super_auto_suggestion_box`** for the `MSuggest` adapter, account-tree and
    master-data typeaheads, manual SKU/product entry, and the grouped **More**
    spotlight search.
  - **`super_table_field`**, **`super_tree_field`** and **`super_tab_bar`** for
    their respective focused interfaces.
- `pubspec.lock` is intentionally omitted because this environment cannot run
  Flutter. Run `flutter pub get` after extraction to resolve the declared
  package versions and generate a fresh lockfile.

- Icons map to Material equivalents (the web kit drew inline SVG paths) — dependency-free.
- Fonts fall back to the platform UI font until the GL families are dropped into `assets/fonts/`.
- A separate single-screen project (`flutter_mobile_dashboard/`) ports the standalone
  "Mobile Dashboard" with light/dark + RTL; this project is the full multi-screen app.
