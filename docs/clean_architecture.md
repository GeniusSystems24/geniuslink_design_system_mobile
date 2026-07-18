# Clean Architecture boundaries

The project is organised feature-first. Each feature may expose the following layers:

```text
lib/features/<feature>/
├── domain/
│   ├── entities/          # Framework-free business data and rules
│   ├── repositories/      # Abstract contracts, when persistence is required
│   ├── usecases/          # Application-specific business operations
│   └── domain.dart
├── data/
│   ├── datasources/       # API, database, cache, or demo-data access
│   ├── models/            # DTOs and serialisation-only models
│   ├── repositories/      # Implementations of domain contracts
│   └── data.dart
└── presentation/
    ├── bloc/              # UI state machines
    ├── controllers/       # Flutter/controller adapters
    ├── models/            # UI-only metadata such as navigation configuration
    ├── pages/
    ├── widgets/
    └── presentation.dart
```

## Dependency rule

Dependencies point inward:

- `domain` imports neither Flutter nor any outer layer.
- `data` may import `domain`, but never `presentation`.
- `presentation` may import `domain`, but never `data`.
- `lib/app/router` and application bootstrap code form the composition root. They may create data sources and inject domain entities into screens.

## Screen data

Business data consumed by screens is represented by immutable domain entities. Examples include `Account`, `CurrencyDefinition`, `ProductDetail`, `JournalEntrySummary`, `StoreSummary`, and `MobileDashboardCatalog`.

Demo fixtures are stored in `data/datasources` and are injected by the composition root:

```dart
ProductsListScreen(products: MockInventoryDataSource.products)
```

Screens do not create or import mock data sources. Reusable screens accept domain entities through constructors and expose callbacks for selections or submissions.

## Presentation-only models

Metadata that exists solely to render or navigate the interface is not a domain entity. `NavigationGroup` and `SettingsNavigationSection`, for example, stay under `presentation/models` because route IDs and icon names are UI concerns.

## Controller separation

Flutter controllers must not be embedded in entities. `InventoryLine` is a pure domain entity, while `InventoryLineFormController` is a presentation adapter that owns `SuperNumericFieldController` instances and converts them to an `InventoryLine` at the boundary.

## Automated guard

Run:

```bash
python tool/check_clean_architecture.py
```

The guard checks dependency direction, forbidden framework imports in Domain, local import/export paths, domain entity immutability, reusable public screen constructors, and accidental business-model declarations in Presentation.
