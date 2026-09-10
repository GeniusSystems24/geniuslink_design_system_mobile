# Flutter Screen Componentization Standard Skill

## Purpose

Refactor any existing Flutter screen into modular, reusable, customizable, responsive, accessible, and testable UI components while preserving the current visual output, behavior, state flow, and public APIs.

This skill is intentionally generic. It must work for dashboards, forms, list/detail screens, settings, admin panels, workflows, mobile/tablet/desktop layouts, and reusable design-system screens.

The refactor must follow current official Flutter guidance where it applies, while respecting the architecture and conventions already established by the project.

---

## Primary Goal

Given an existing Flutter screen:

1. Inspect the implementation before changing it.
2. Identify responsibilities and repeated UI patterns.
3. Separate screen composition from reusable UI components.
4. Keep business/data logic outside reusable widgets.
5. Make reusable components customizable through small, typed APIs.
6. Preserve adaptive/responsive behavior.
7. Preserve accessibility, localization, interaction, and state behavior.
8. Reduce rebuild cost and avoid unnecessary widget complexity.
9. Add or update tests when the project already has a testing structure.
10. Apply the refactor to the project files; do not only describe it.

Do not redesign the screen unless explicitly requested.

---

# Flutter Guidelines Alignment

Apply these Flutter principles throughout the refactor.

## Separation of concerns

Flutter's architecture guidance strongly recommends separating UI concerns from data/business logic.

A reusable UI component should mainly:

- render state
- perform layout
- expose user interactions through callbacks
- contain animation logic that is inherently visual
- contain simple conditional rendering

It should not perform:

- repository access
- API calls
- persistence
- business calculations
- unrelated validation/business rules
- cross-feature orchestration

If the project already uses ViewModels, Controllers, Blocs, Cubits, Riverpod Notifiers, ChangeNotifiers, or another state-management pattern, preserve it.

Do not migrate the entire feature to another architecture as part of componentization.

---

## Declarative UI and unidirectional state flow

Treat UI as a function of state.

Prefer:

```text
state/data
   ↓
widget tree
   ↓
user event
   ↓
callback / command
   ↓
existing state-management layer
```

Avoid reusable widgets mutating shared application state directly.

Prefer immutable input/configuration objects when practical.

---

# Source of Truth

Use this priority:

```text
existing Flutter implementation
→ project design system and theme
→ tests/specifications
→ screenshots/Figma/mockups
```

A screenshot is a visual reference, not a replacement for inspecting the implementation.

Do not rebuild existing behavior from a screenshot when source code is available.

---

# Componentization Rules

## Extract by responsibility

Extract a component when it has a meaningful UI responsibility, for example:

- section header
- metric card
- status badge
- toolbar
- summary card
- quick action
- list row
- filter control
- selector
- empty/loading/error state
- reusable information group

Do not extract based only on line count.

---

## Prefer widgets over helper methods

For reusable UI pieces, prefer a `StatelessWidget` or `StatefulWidget` over helper methods that return `Widget`.

Prefer:

```dart
class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

over:

```dart
Widget buildMetricCard(...) {
  // ...
}
```

This gives Flutter clearer widget boundaries and enables `const` construction and more localized rebuilds.

A tiny private helper method is still acceptable when it is purely implementation detail and does not represent a reusable widget responsibility.

---

## Avoid over-fragmentation

Do not create components that add no meaningful abstraction.

Avoid structures such as:

```text
CardTitleText
CardValueText
CardPadding
CardContainer
```

when they are single-use implementation details.

Extract enough to clarify responsibilities, not to maximize the number of files/classes.

---

# Component Classification

Classify extracted components before deciding their location.

## Primitive

Small reusable visual element.

Examples:

```text
StatusBadge
SectionDivider
IconLabel
MetricValue
ActionIcon
```

## Composite

Combines primitives into one reusable UI unit.

Examples:

```text
MetricCard
ActionTile
InfoRow
SummaryCard
SearchField
```

## Section

A meaningful screen section that composes multiple components.

Examples:

```text
OverviewSection
ActivitySection
QuickActionsSection
FilterSection
```

## Screen/View

Owns screen-level composition and connects UI to existing state/navigation.

Examples:

```text
DashboardScreen
AccountDetailsScreen
SettingsScreen
```

Not every screen needs every level.

---

# Extraction Decision

Extract when one or more are true:

- the pattern appears more than once
- the pattern is likely to be reused
- it has a clear responsibility
- it has a meaningful independent visual API
- it benefits from independent theming
- it benefits from independent testing
- it contains an interaction pattern that should be standardized
- extraction reduces a large `build()` method without hiding important flow
- localizing its rebuild scope improves maintainability/performance

Do not extract when:

- it is trivial and single-use
- its API would be larger than its implementation
- it requires many screen-specific dependencies
- extraction makes screen flow harder to understand
- it is an implementation detail with no useful boundary

---

# Reuse Scope

Determine the correct reuse scope for each component.

## Screen-local

Use when meaningful only to one screen.

Keep it near that screen according to the project's conventions.

## Feature-shared

Use when reused by multiple screens in the same feature.

## App-shared / UI core

Use for components used across unrelated features.

When the project follows Flutter's recommended naming conventions, prefer a shared location such as:

```text
ui/core/
```

rather than a generic top-level directory named only:

```text
widgets/
```

because Flutter recommends avoiding names that can be confused with SDK concepts.

If the project already has an established shared/design-system structure, preserve it instead of forcing a new directory convention.

## Design-system level

Promote only stable, broadly reusable visual primitives/patterns.

Do not move every extracted screen widget into the design system.

---

# Naming Standard

Name by responsibility.

Good:

```text
SectionHeader
MetricCard
StatusBadge
ActionTile
FilterBar
SummaryPanel
InfoRow
EmptyState
```

Avoid vague names:

```text
CustomWidget
CommonWidget
ReusableWidget
MyWidget
BoxWidget
```

Avoid unnecessary screen prefixes when the component is generic.

Prefer:

```text
TransactionTile
```

over:

```text
DashboardTransactionTile
```

unless the latter is intentionally screen-specific.

---

# Public API Design

Reusable component APIs should be:

- typed
- null-safe
- small
- predictable
- composable
- easy to discover
- difficult to misuse

Prefer:

```dart
MetricCard(
  data: metric,
  onTap: onTap,
  theme: metricTheme,
)
```

over constructors with many unrelated style fields.

Use required parameters only for truly required data.

Use sensible defaults.

Use `const` constructors wherever possible.

Avoid introducing breaking changes to unrelated public APIs.

---

# Data and Configuration

Do not hard-code business data inside reusable widgets.

For generic visual components, do not require a feature/domain model unless the model itself is intentionally part of the component contract.

Prefer direct presentation inputs and visual slots when the component only needs to render content in specific positions.

Bad:

```dart
class MetricCard extends StatelessWidget {
  // Internal literals:
  // "Total balance"
  // "2,680,900"
}
```

Good:

```dart
MetricCard(
  label: metric.label,
  value: metric.value,
)
```

For repeated UI configuration, introduce lightweight immutable display models only when they genuinely improve clarity.

Do **not** introduce a display model merely to pass data into a generic visual component that can accept direct values or widget slots more cleanly.

For example, prefer:

```dart
TwoRowTile(
  topStart: Text(title),
  topEnd: amountWidget,
  bottomStart: metadataWidget,
  bottomEnd: timeWidget,
)
```

over introducing:

```dart
TwoRowTileData(...)
```

just to wrap those four values.

A display model is appropriate when several components share the same prepared presentation data or when it represents a meaningful presentation concept.

Reuse existing domain models when appropriate, but do not make generic UI widgets depend on them unless that dependency is intentional.

---

# State Management

Preserve the project's existing state-management approach.

This skill must work with:

- `setState`
- `ValueNotifier`
- `ChangeNotifier`
- Provider
- Riverpod
- Bloc/Cubit
- MobX
- GetX
- Redux
- custom controllers/view models

Reusable components should normally receive state and callbacks.

Example:

```dart
PeriodSelector(
  selectedValue: state.period,
  onChanged: controller.changePeriod,
)
```

Keep state local only when it is truly presentation-local.

Examples:

- hover state
- focus state
- animation controller owned by that component
- temporarily expanded/collapsed state when not part of feature state

Do not duplicate an existing source of truth inside a child widget.

---

# Rebuild and Performance Rules

Flutter recommends keeping `build()` inexpensive and splitting large widgets based on encapsulation and update boundaries.

Apply these rules:

- avoid expensive calculations inside `build()`
- avoid unnecessary object creation when stable values can be reused
- use `const` widgets where possible
- localize state changes to the smallest reasonable subtree
- do not move `setState()` higher than necessary
- do not rebuild unrelated large sections for a small local UI change
- prefer builder/lazy list APIs for large or mostly off-screen collections
- avoid unnecessary intrinsic layout passes
- avoid unnecessary clipping or opacity layers
- do not override `operator ==` on widget classes as a rebuild optimization

Do not perform speculative micro-optimizations that reduce readability without evidence.

---


# Presentation-First Component APIs

Reusable visual components should be designed around their **layout contract**, not around a feature-specific model.

A generic or broadly reusable widget should not require a domain or feature model such as:

```dart
BankMovementTile(
  movement: movement,
)
```

when the widget itself only needs to render content in known visual positions.

Prefer direct presentation inputs:

```dart
TwoRowTile(
  topStart: ...,
  topEnd: ...,
  bottomStart: ...,
  bottomEnd: ...,
)
```

This keeps the component:

- independent from feature/domain models
- reusable across unrelated screens
- easy to compose
- easy to theme
- easier to test in isolation
- less coupled to business semantics

## Name properties by visual role or layout position

When a component is primarily structural/presentational, name its fields according to where content appears in the layout rather than according to one screen's business meaning.

Prefer:

```dart
final Widget? topStart;
final Widget? topEnd;
final Widget? bottomStart;
final Widget? bottomEnd;
```

over:

```dart
final Widget? title;
final Widget? amount;
final Widget? reference;
final Widget? transactionType;
final Widget? timestamp;
```

when the component itself does not need to understand those meanings.

Use business-specific names only when the business meaning is part of the component's real contract.

## Prefer directional naming

For reusable Flutter components, prefer directional names such as:

```text
start
end
topStart
topEnd
bottomStart
bottomEnd
```

instead of:

```text
left
right
topLeft
topRight
```

This allows the component to work naturally with both LTR and RTL layouts.

The implementation should also prefer Flutter directional APIs where appropriate, such as:

```dart
AlignmentDirectional
EdgeInsetsDirectional
BorderRadiusDirectional
```

## Prefer `Widget` for customizable visual slots

When a region can reasonably contain different visual content, prefer a `Widget` slot.

Example:

```dart
class TwoRowTile extends StatelessWidget {
  const TwoRowTile({
    super.key,
    this.topStart,
    this.topEnd,
    this.bottomStart,
    this.bottomEnd,
    this.leading,
    this.trailing,
    this.onTap,
    this.theme,
  });

  final Widget? topStart;
  final Widget? topEnd;
  final Widget? bottomStart;
  final Widget? bottomEnd;

  final Widget? leading;
  final Widget? trailing;

  final VoidCallback? onTap;
  final TwoRowTileTheme? theme;

  @override
  Widget build(BuildContext context) {
    // Layout only.
  }
}
```

This allows the caller to pass:

```dart
Text(...)
Icon(...)
StatusBadge(...)
MoneyAmount(...)
Row(...)
Column(...)
CustomWidget(...)
```

without modifying the reusable component.

## Do not force visual slots to depend on feature data models

Avoid:

```dart
class BankMovementTile extends StatelessWidget {
  final BankMovementItem movement;
}
```

when the tile only needs visual content.

Prefer:

```dart
class TwoRowTile extends StatelessWidget {
  final Widget? topStart;
  final Widget? topEnd;
  final Widget? bottomStart;
  final Widget? bottomEnd;
}
```

Then let the feature compose it:

```dart
TwoRowTile(
  topStart: Text(movement.title),
  topEnd: MoneyAmount(
    amount: movement.amount,
    currency: movement.currency,
  ),
  bottomStart: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(movement.reference),
      const SizedBox(width: 8),
      StatusBadge(
        label: Text(movement.typeLabel),
      ),
    ],
  ),
  bottomEnd: Text(movement.relativeTimeLabel),
)
```

The feature remains responsible for translating business data into presentation.

## Keep feature semantics outside generic components

A generic visual component should not decide:

- whether an amount is a deposit or withdrawal
- whether a status is critical
- how a domain enum maps to text
- how a domain model is formatted
- how business rules affect colors

The caller should prepare the content and pass the resulting widgets.

For example, avoid:

```dart
TwoRowTile(
  movementType: BankMovementType.withdrawal,
)
```

if the tile only needs a badge widget.

Prefer:

```dart
TwoRowTile(
  bottomStart: StatusBadge(
    label: const Text('WITHDRAWAL'),
    status: StatusType.error,
  ),
)
```

## Separate generic layout components from feature adapters

When a feature benefits from a convenience wrapper, use composition instead of coupling the generic widget.

Example:

```text
BankMovementTile
        ↓
     TwoRowTile
```

`TwoRowTile` stays generic.

`BankMovementTile`, if it exists, may remain feature-specific and translate feature data into the generic layout.

Only create the feature wrapper when it adds meaningful value. If the generic component is already clear to use directly, do not add an unnecessary adapter.

## Use scalar values when they are truly part of layout behavior

Not every field should become a `Widget`.

Use scalar or typed values when the component itself genuinely owns that behavior.

Good examples:

```dart
final bool enabled;
final bool expanded;
final VoidCallback? onTap;
final EdgeInsetsGeometry? padding;
final AlignmentGeometry alignment;
final TileDensity density;
```

Use `Widget` for visual content slots, not as a replacement for every typed property.

## Layout contract over business contract

For generic reusable presentation components, define the API around:

```text
where content goes
+ how the layout behaves
+ what interactions are exposed
+ how the component is themed
```

not around:

```text
which feature model happens to use it first
```

This is a key rule of this standard.


# Customization Standard

Reusable components must be customizable without editing their internal source.

Customization should be divided into:

```text
data
interaction
theme
optional structure
```

Do not expose internal implementation details unnecessarily.

---

# Flutter-Aligned Theme Resolution

Follow Flutter's theme resolution principle:

```text
explicit per-widget override
→ nearest component/feature theme
→ application ThemeData/design system
→ component fallback
```

The default appearance after refactoring must match the existing screen.

A consumer should be able to customize the component while preserving app-wide theme behavior.

---

# Component Theme Objects

For non-trivial components, prefer a typed theme object over a constructor with many style fields.

Example:

```dart
@immutable
class MetricCardTheme {
  const MetricCardTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.labelStyle,
    this.valueStyle,
    this.iconColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Color? iconColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
}
```

Usage:

```dart
MetricCard(
  data: metric,
  theme: customMetricCardTheme,
)
```

Do not add theme classes for trivial components when `ThemeData` or an existing project theme already provides everything needed.

---

# Feature Theme

When multiple related components share styling, group their component themes.

Example:

```dart
@immutable
class DashboardTheme {
  const DashboardTheme({
    this.sectionHeaderTheme,
    this.metricCardTheme,
    this.actionTileTheme,
    this.statusBadgeTheme,
  });

  final SectionHeaderTheme? sectionHeaderTheme;
  final MetricCardTheme? metricCardTheme;
  final ActionTileTheme? actionTileTheme;
  final StatusBadgeTheme? statusBadgeTheme;
}
```

This allows feature-wide customization plus per-instance overrides.

---

# ThemeData and ThemeExtension

Use Flutter's existing theming mechanisms first.

Prefer:

- `Theme.of(context)`
- `ColorScheme`
- `TextTheme`
- Material component themes
- existing project design-system themes
- inherited component/feature themes
- `ThemeExtension` when the project already uses it or when a custom app-wide theme contract is justified

Do not create a competing theme system when the project already has one.

Do not hard-code a dark appearance because the reference screen happens to be dark.

Components should support light, dark, and branded themes through the project's normal theming path.

---

# Theme Properties to Consider

Expose only relevant customization, such as:

- background / foreground
- accent color
- title/subtitle/value text styles
- icon styling
- border
- radius
- elevation/shadow
- padding/gaps
- divider styling
- selected/unselected
- hover/focus/pressed/disabled
- success/warning/error/neutral statuses

Do not expose every Flutter style primitive by default.

---

# Structural Customization

For reusable visual components, prefer widget slots for content regions that may vary.

Examples:

```dart
final Widget? leading;
final Widget? trailing;
final Widget? topStart;
final Widget? topEnd;
final Widget? bottomStart;
final Widget? bottomEnd;
```

Name those slots by visual role or layout position when the component is generic.

Use semantic/business names only when that meaning is intrinsic to the component itself.

Do not automatically replace every scalar property with `Widget`.

Use typed/scalar values when the component genuinely owns their semantics or behavior.

For example:

```dart
final bool expanded;
final TileDensity density;
final EdgeInsetsGeometry? padding;
```

A text-only API such as:

```dart
final String title;
```

is still appropriate when consistent text rendering is intentionally part of that component's contract.

---

# Builders

Use builders for advanced customization only when theme/configuration is insufficient.

Examples:

```dart
final Widget Function(
  BuildContext context,
  MetricItemData item,
)? itemBuilder;
```

Good builder use cases:

- custom item rendering
- custom empty/loading/error state
- complex trailing content
- replaceable content region

Avoid builders that expose every internal element.

---

# Adaptive and Responsive Layout

Flutter recommends designing from available space rather than hardware/device labels.

Do not branch layout based on:

```text
phone
tablet
desktop
device model
hardware type
```

when available width/constraints are the real requirement.

## Use `LayoutBuilder` for local component constraints

When a component should adapt to the space its parent gives it, prefer:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    // respond to constraints.maxWidth
  },
)
```

This is usually the correct choice for reusable components.

## Use `MediaQuery.sizeOf(context)` for window-level decisions

Use it when layout behavior depends on the current app window size rather than a specific parent's constraints.

Prefer specialized `MediaQuery` accessors such as `sizeOf` instead of depending on all `MediaQuery` data unnecessarily.

## Do not use orientation as the main breakpoint

Avoid choosing layouts primarily with:

```dart
MediaQuery.orientationOf(context)
OrientationBuilder
```

Use available width/constraints instead.

## Avoid fixed-size assumptions

Avoid unnecessary:

- fixed heights
- fixed widths
- full-width controls on very large windows
- magic breakpoints scattered across components

Reuse project/design-system breakpoints when available.

## Preserve state across size changes

Changing window size, orientation, split-screen mode, or fold state should not unnecessarily reset feature state.

---

# Safe Areas

Respect display cutouts, system UI, and rounded screen boundaries.

At the screen/layout boundary, use `SafeArea` where appropriate.

Do not add nested `SafeArea` widgets to every extracted component automatically.

A reusable child component should generally respect the constraints provided by its parent rather than independently applying screen-level safe-area behavior.

---

# Input Devices and Desktop/Web

Do not assume touch-only interaction.

When relevant, preserve/support:

- mouse
- trackpad
- keyboard
- hover
- focus
- shortcuts
- tooltips

Do not remove existing keyboard/focus behavior during extraction.

---

# Accessibility

Refactoring must not regress accessibility.

Preserve or improve:

- `Semantics`
- labels
- button roles
- tooltips
- focus order
- keyboard access
- screen-reader clarity
- tap target sizes
- text scaling
- contrast
- error descriptions

## Tap targets

Aim for Flutter's recommended accessible interaction size of at least approximately `48x48` logical pixels for interactive controls, unless the project/platform design system provides an equivalent accessible standard.

## Contrast

Keep text/control contrast accessible.

As a baseline:

```text
4.5:1 for normal/small text
3:1 for large text
```

Do not rely on color alone to communicate important state.

## Text scaling

Do not disable or arbitrarily clamp system text scaling merely to preserve a screenshot.

Layouts must remain usable at large accessibility text scales.

Avoid fixed heights around text when text can wrap or scale.

---

# Localization and Directionality

Preserve the project's localization system.

Do not hard-code user-facing strings if localization already exists.

Support localized content with different lengths.

Respect inherited `Directionality`.

Components should work correctly in both:

```text
LTR
RTL
```

where the application supports them.

Prefer directional APIs when appropriate, for example:

```dart
EdgeInsetsDirectional
AlignmentDirectional
```

instead of encoding left/right assumptions into reusable components.

Do not add a new localization framework as part of component extraction.

---

# Interaction Preservation

Preserve:

- taps
- gestures
- navigation
- menus
- selection
- focus
- hover
- keyboard actions
- animations
- scrolling
- drag/drop
- loading
- empty
- error
- disabled
- expanded/collapsed state

A visually correct refactor that changes behavior is not acceptable.

---

# Lists and Repeated Content

For large/dynamic collections:

Prefer lazy APIs such as:

```dart
ListView.builder
GridView.builder
SliverList
SliverGrid
```

when appropriate.

Do not eagerly build large off-screen collections solely because the original screen was extracted into a component.

Preserve keys where item identity matters.

---

# Keys

Use keys intentionally.

Keep or introduce keys when needed for:

- preserving state across reordering
- list item identity
- testing
- animated transitions

Do not add `GlobalKey` unless its capabilities are actually required.

Do not use keys as a substitute for correct state ownership.

---

# Existing Design-System Reuse

Before creating a new component, inspect the project for existing:

- cards
- buttons
- typography
- badges
- fields
- list tiles
- spacing tokens
- colors
- icons
- loaders
- dialogs
- menus
- responsive utilities

Prefer composing existing design-system APIs over duplicating them.

---

# File Organization

Follow existing project structure first.

If the project already has a clear UI architecture, place extracted components within it.

For new/shared UI organization aligned with Flutter architecture naming, prefer something conceptually like:

```text
lib/
└── ui/
    ├── core/
    │   ├── themes/
    │   └── components/
    └── <feature>/
        ├── <feature>_screen.dart
        ├── <feature>_view_model.dart
        └── components/
```

This is guidance, not a mandatory folder tree.

Do not restructure unrelated project directories during a screen componentization task.

---

# Testing

Flutter recommends testing architectural components independently and together.

When the project has tests, update/add tests for extracted reusable components where the refactor creates meaningful behavior boundaries.

At minimum, important reusable components should be suitable for widget tests that can verify:

- default rendering
- custom theme override
- callbacks
- selected/disabled/error states
- text scaling where relevant
- RTL where supported

Use golden tests only when the project already relies on them or visual regression testing is genuinely valuable.

For accessibility-sensitive components, consider Flutter accessibility guideline tests where the project testing setup supports them.

Do not introduce a large new testing framework solely for this refactor.

---

# Lints and Formatting

Follow the project's analyzer/lint configuration.

If the project uses `flutter_lints`, preserve compliance with it.

After refactoring:

- format modified Dart files
- remove unused imports
- resolve analyzer issues introduced by the refactor
- do not suppress legitimate warnings merely to finish the task

Do not modify lint rules unless explicitly requested.

---

# Refactoring Workflow

## Step 1 — Inspect

Review:

- screen code
- local/private widgets
- state dependencies
- design-system usage
- theme resolution
- interaction behavior
- repeated patterns
- responsive behavior
- localization
- accessibility
- existing tests

## Step 2 — Inventory

Identify:

- primitives
- composites
- sections
- duplicated structures
- screen-level responsibilities

## Step 3 — Decide reuse scope

Classify each candidate as:

```text
screen-local
feature-shared
app-shared/ui-core
design-system
```

## Step 4 — Define component contracts

For each extracted component, define only the needed:

```text
data
callbacks
theme/configuration
slots/builders
```

## Step 5 — Define state ownership

Before moving code, explicitly determine which layer owns each state value.

Do not accidentally move feature state into reusable widgets.

## Step 6 — Extract widgets

Prefer `StatelessWidget` unless local mutable state is genuinely required.

Use `const` constructors where possible.

## Step 7 — Consolidate duplication

Replace structurally identical components with configurable reusable components.

Do not create an over-generic universal widget.

## Step 8 — Add theming

Resolve visual values through:

```text
explicit override
→ local feature/component theme
→ ThemeData/design system
→ fallback
```

## Step 9 — Preserve responsiveness

Use constraints rather than device labels.

Prefer `LayoutBuilder` inside reusable components.

## Step 10 — Recompose screen

The screen should become easier to scan and should primarily show feature composition and state wiring.

## Step 11 — Clean up

Remove:

- obsolete private widgets
- duplicated styles
- dead helpers
- unused imports
- redundant constants

## Step 12 — Validate

Check:

- visual parity
- behavioral parity
- state ownership
- responsiveness
- light/dark themes
- text scaling
- RTL if supported
- tests
- analyzer/lints

---

# Anti-Patterns

Avoid the following.

## Giant `build()` after fake extraction

Do not simply move one huge widget tree into a single new file/class.

Component boundaries must have responsibilities.

## Helper-method componentization

Do not replace a large widget tree with dozens of `Widget _buildX()` methods when reusable widget boundaries are appropriate.

## Giant configurable component

Avoid:

```dart
GenericCard(
  isMetric: true,
  isAction: false,
  isWarning: true,
  showBadge: true,
  // ...
)
```

Prefer focused components and typed variants.

## Boolean state explosion

Prefer enums:

```dart
StatusBadge(
  status: StatusType.warning,
)
```

over:

```dart
StatusBadge(
  isWarning: true,
  isError: false,
  isSuccess: false,
)
```

## Hard-coded screen theme

Do not copy one screen's literal colors/fonts into shared components as permanent defaults.

## Device-type responsive logic

Avoid:

```dart
if (isTablet) ...
if (isPhone) ...
```

when the actual decision is about available constraints.

## Stateful widget by default

Do not convert extracted components into `StatefulWidget` unless they own real local UI state.

## Premature global reuse

Do not put a one-screen component into `ui/core` or the design system without evidence of broader reuse.

## Logic leakage

Do not make shared components fetch repositories, read route arguments, or depend directly on a feature controller unless they intentionally belong to that feature boundary.

---


## Feature-model coupling in generic visual widgets

Avoid:

```dart
class GenericTransactionTile extends StatelessWidget {
  final Transaction transaction;
}
```

when the widget only renders content in fixed layout slots.

Prefer direct visual inputs or compose a feature-specific adapter above the generic component.

## Business-specific names for generic layout slots

Avoid:

```dart
amount
reference
transactionType
timestamp
```

inside a generic two-row layout component.

Prefer:

```dart
topStart
topEnd
bottomStart
bottomEnd
```

when the component is purely structural.


# Required Verification Checklist

Before completing the task, verify:

- [ ] Default rendering matches the original screen.
- [ ] Existing interactions still work.
- [ ] Existing navigation is preserved.
- [ ] Existing state-management architecture is preserved.
- [ ] UI and business/data responsibilities remain separated.
- [ ] Repeated visual patterns are consolidated.
- [ ] Reusable pieces are real widgets rather than unnecessary helper methods.
- [ ] `const` constructors are used where practical.
- [ ] Local state/rebuilds are scoped appropriately.
- [ ] Components have meaningful names.
- [ ] Components are stored at the correct reuse scope.
- [ ] Business data is not hard-coded in reusable components.
- [ ] Generic visual components do not depend on feature/domain models unless intentionally required.
- [ ] Visual content slots are named by layout role/position when the component is generic.
- [ ] Directional names (`start`/`end`) are used instead of `left`/`right` where appropriate.
- [ ] Widget slots are used for visual regions that require flexible composition.
- [ ] Feature semantics are translated by the caller rather than embedded in generic layout widgets.
- [ ] Theme defaults come from ThemeData/design system where appropriate.
- [ ] Components support meaningful per-instance customization.
- [ ] Light/dark behavior is preserved.
- [ ] Layout uses available constraints rather than device labels.
- [ ] Orientation is not used as the primary responsive breakpoint.
- [ ] Safe-area behavior is preserved at the correct layout level.
- [ ] Text scaling remains usable.
- [ ] Accessibility semantics/interactions are preserved.
- [ ] RTL works where the app supports it.
- [ ] Localization behavior is preserved.
- [ ] Large lists remain lazy where appropriate.
- [ ] Existing keys/state identity are preserved where necessary.
- [ ] Tests are updated where appropriate.
- [ ] Modified Dart code is formatted.
- [ ] No analyzer/lint errors were introduced.

---

# Customization Verification

For each non-trivial reusable component, verify both default and customized usage.

Default:

```dart
MetricCard(
  data: metric,
)
```

Customized:

```dart
MetricCard(
  data: metric,
  theme: customMetricCardTheme,
)
```

If feature-level theming is justified:

```dart
DashboardScreen(
  theme: customDashboardTheme,
)
```

A consumer should be able to change appropriate visual properties such as colors, typography, radius, border, spacing, status palette, and icon presentation without editing the reusable component source.

---

# Expected Deliverables

Apply the changes to the project.

Provide:

1. Refactored screen/view files.
2. Extracted reusable component files.
3. Theme/configuration classes where justified.
4. Lightweight immutable display models where justified.
5. Updated imports/exports if needed.
6. Widget tests or updated tests where appropriate.
7. A concise summary containing:
   - components extracted
   - duplicate patterns consolidated
   - reuse scope selected
   - theming/customization added
   - responsive/accessibility considerations
   - files added/modified
8. Any assumptions or intentionally unchanged areas.

Do not only return recommendations when the task asks for implementation.

---

# Final Standard

Optimize for:

```text
clear responsibility
+ composition
+ layout-driven component APIs
+ practical reuse
+ low feature-model coupling
+ explicit state ownership
+ controlled customization
+ ThemeData integration
+ adaptive constraints
+ RTL-friendly directional layout
+ accessibility
+ localization
+ testability
+ efficient rebuilds
+ preserved behavior
```

Do not optimize for:

```text
maximum component count
maximum configurability
a new architecture
or a new design system
```

unless explicitly requested.

---

# Official Flutter References

This standard is aligned with the following official Flutter documentation:

- https://docs.flutter.dev/app-architecture/guide
- https://docs.flutter.dev/app-architecture/recommendations
- https://docs.flutter.dev/app-architecture/concepts
- https://docs.flutter.dev/ui/adaptive-responsive/general
- https://docs.flutter.dev/ui/adaptive-responsive/best-practices
- https://docs.flutter.dev/ui/adaptive-responsive/safearea-mediaquery
- https://docs.flutter.dev/cookbook/design/themes
- https://docs.flutter.dev/perf/best-practices
- https://docs.flutter.dev/ui/accessibility
- https://docs.flutter.dev/ui/accessibility/ui-design-and-styling
- https://docs.flutter.dev/ui/accessibility/accessibility-testing
- https://docs.flutter.dev/ui/internationalization
- https://docs.flutter.dev/testing/overview
- https://docs.flutter.dev/cookbook/testing/widget/introduction
