# Stocks Watchlist

A Flutter application for managing multiple stock watchlists with drag-and-drop reordering, inline renaming, and instrument management — built using Clean Architecture and the BLoC pattern.

## Demo

https://github.com/Js112001/stocks_watchlist/assets/demo.mp4

## Features

- **Multiple Watchlists** — 3 independent watchlists, each with its own set of instruments, accessible via tabs
- **Drag & Drop Reordering** — Reorder instruments within a watchlist using long-press drag handles
- **Delete Instruments** — Remove instruments from a watchlist via the edit screen
- **Rename Watchlists** — Rename any watchlist; changes reflect on the tab labels
- **Draft Editing** — All edits (reorder, delete, rename) are staged in a draft and only committed on save
- **Search Bar** — Global search bar above tabs (UI placeholder, ready for implementation)
- **Sort Bar** — Per-tab sort control (UI placeholder, ready for implementation)

## Tech Stack

| Dependency     | Purpose                          |
|----------------|----------------------------------|
| `flutter_bloc` | State management (Bloc pattern)  |
| `get_it`       | Dependency injection             |

## Project Structure

```
lib/
├── main.dart                          # App entry point, MultiBlocProvider setup
├── di/
│   └── service_locator.dart           # GetIt DI registration
├── features/
│   └── watchlist/
│       ├── data/                      # Data layer
│       │   ├── models/
│       │   │   └── instrument_model.dart    # Serializable model (extends entity)
│       │   ├── repository/
│       │   │   └── watchlist_repository_impl.dart  # Repository implementation
│       │   └── services/
│       │       └── stock_api_service.dart    # API service (returns sample data)
│       ├── domain/                    # Domain layer (pure business logic)
│       │   ├── entities/
│       │   │   └── instrument.dart          # Core entity
│       │   ├── repository/
│       │   │   └── watchlist_repository.dart # Abstract repository contract
│       │   └── usecases/
│       │       └── get_watchlist.dart        # Use case
│       └── presentation/             # Presentation layer
│           ├── bloc/
│           │   ├── watchlist_bloc.dart       # Bloc with event handlers
│           │   ├── watchlist_event.dart      # Sealed event classes
│           │   └── watchlist_state.dart      # Immutable state + EditDraft
│           ├── screens/
│           │   ├── watchlist_screen.dart     # Main screen with tabs
│           │   └── edit_watchlist_screen.dart # Edit screen (stateless, bloc-driven)
│           └── widgets/
│               ├── instrument_tile.dart      # Instrument list item
│               ├── search_bar.dart           # Search input widget
│               └── sort_bar.dart             # Sort control widget
└── utils/
    ├── app_constants.dart             # All constant strings
    └── app_textstyle.dart             # Shared text styles
```

## Architecture

The project follows **Clean Architecture** with three layers:

```
Presentation  →  Domain  ←  Data
```

- **Domain** — Contains entities, abstract repository contracts, and use cases. Has zero dependencies on other layers.
- **Data** — Implements the domain repository. Contains models (with serialization), services (API calls), and the repository implementation.
- **Presentation** — Contains the Bloc, screens, and widgets. Depends only on the domain layer (entities and use cases).

### Data Flow

```
Screen → Bloc → UseCase → Repository (abstract) → RepositoryImpl → Service
```

### Dependency Injection

All dependencies are registered in `service_locator.dart` using `get_it`:

| Registration         | Type            | Reason                                      |
|----------------------|-----------------|---------------------------------------------|
| `StockApiService`    | Lazy Singleton  | Stateless service, one instance is enough    |
| `WatchlistRepository`| Lazy Singleton  | Single source of truth for data access       |
| `GetWatchlist`       | Lazy Singleton  | Stateless use case                           |
| `WatchlistBloc`      | Factory         | New instance per provider (blocs are stateful)|

## Reordering Approach

The reordering system uses a **draft-based editing pattern** to ensure the main watchlist data is never mutated until the user explicitly saves.

### How It Works

1. **Start Editing** — When the user taps the edit FAB, a `StartEditing` event is dispatched. The bloc copies the current watchlist's instruments and name into an `EditDraft` object within the state.

2. **Draft Mutations** — All edits on the edit screen operate on the draft, not the main data:
   - `ReorderDraft(oldIndex, newIndex)` — Reorders items within the draft list
   - `DeleteDraftItem(index)` — Removes an item from the draft list
   - `UpdateDraftName(name)` — Updates the draft watchlist name

3. **Save** — When "Save Watchlist" is pressed, a `SaveDraft` event is dispatched. The bloc commits the draft's instruments and name back into the main `watchlists` and `names` maps, then clears the draft.

4. **Cancel** — If the user navigates back without saving, the draft is abandoned. The main data remains unchanged.

### Why This Approach?

- **No `setState`** — The edit screen is a `StatelessWidget`. All UI updates come from `BlocBuilder`, making the screen fully reactive and testable.
- **Atomic saves** — Reordering, deletions, and renames are batched into a single save operation. The user can make multiple changes and commit them all at once, or discard everything by going back.
- **Single source of truth** — The `WatchlistBloc` holds all state. No local mutable lists or flags in the widget tree.

### State Structure

```dart
class WatchlistState {
  final Map<int, WatchlistStatus> statuses;    // Loading status per watchlist
  final Map<int, List<Instrument>> watchlists; // Instruments per watchlist
  final Map<int, String> names;                // Custom names per watchlist
  final EditDraft? editDraft;                  // Active draft (null when not editing)
}

class EditDraft {
  final int watchlistIndex;          // Which watchlist is being edited
  final List<Instrument> instruments; // Mutable copy of instruments
  final String name;                  // Mutable copy of name
}
```

### Event Flow Diagram

```
[Edit FAB tapped]
    │
    ▼
StartEditing(index)  →  Creates EditDraft from current data
    │
    ▼
┌─────────────────────────────────┐
│  Edit Screen (reads EditDraft)  │
│                                 │
│  Drag item    → ReorderDraft    │
│  Delete item  → DeleteDraftItem │
│  Rename       → UpdateDraftName │
└─────────────────────────────────┘
    │                    │
    ▼                    ▼
[Save Watchlist]    [Back button]
    │                    │
    ▼                    ▼
SaveDraft           Draft abandoned
(commits to main)   (main data unchanged)
```

## Per-Watchlist Data

Each watchlist tab loads its own data independently. The service returns different sample instruments per watchlist index:

| Tab         | Instruments                              |
|-------------|------------------------------------------|
| Watchlist 1 | RELIANCE, HDFCBANK, ASIANPAINT, MRF      |
| Watchlist 2 | TCS, INFY, WIPRO, NIFTY IT               |
| Watchlist 3 | TATAMOTORS, MARUTI, BAJFINANCE, SBIN     |

## Getting Started

### Prerequisites

- Flutter SDK `^3.10.3`
- Dart SDK `^3.10.3`

### Run the App

```bash
flutter pub get
flutter run
```

### Analyze

```bash
flutter analyze
```

## Future Improvements

- Persist watchlist data locally (Hive / SharedPreferences)
- Implement search functionality
- Implement sort functionality
- Add instrument detail screen
- Connect to a real stock market API
- Add unit and widget tests
