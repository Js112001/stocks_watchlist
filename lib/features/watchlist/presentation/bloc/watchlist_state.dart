import 'package:stocks_watchlist/features/watchlist/domain/entities/instrument.dart';
import 'package:stocks_watchlist/utils/app_constants.dart';

enum WatchlistStatus { initial, loading, loaded, error }

class EditDraft {
  final int watchlistIndex;
  final List<Instrument> instruments;
  final String name;

  const EditDraft({
    required this.watchlistIndex,
    required this.instruments,
    required this.name,
  });

  EditDraft copyWith({
    List<Instrument>? instruments,
    String? name,
  }) {
    return EditDraft(
      watchlistIndex: watchlistIndex,
      instruments: instruments ?? this.instruments,
      name: name ?? this.name,
    );
  }
}

class WatchlistState {
  final Map<int, WatchlistStatus> statuses;
  final Map<int, List<Instrument>> watchlists;
  final Map<int, String> names;
  final EditDraft? editDraft;
  final String? errorMessage;

  const WatchlistState({
    this.statuses = const {},
    this.watchlists = const {},
    this.names = const {},
    this.editDraft,
    this.errorMessage,
  });

  WatchlistStatus statusFor(int index) =>
      statuses[index] ?? WatchlistStatus.initial;

  List<Instrument> instrumentsFor(int index) => watchlists[index] ?? const [];

  String nameFor(int index) =>
      names[index] ?? '${AppConstants.defaultWatchlistName} ${index + 1}';

  WatchlistState copyWith({
    Map<int, WatchlistStatus>? statuses,
    Map<int, List<Instrument>>? watchlists,
    Map<int, String>? names,
    EditDraft? editDraft,
    bool clearDraft = false,
    String? errorMessage,
  }) {
    return WatchlistState(
      statuses: statuses ?? this.statuses,
      watchlists: watchlists ?? this.watchlists,
      names: names ?? this.names,
      editDraft: clearDraft ? null : (editDraft ?? this.editDraft),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
