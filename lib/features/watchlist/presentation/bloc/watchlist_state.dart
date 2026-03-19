import '../../domain/entities/instrument.dart';

enum WatchlistStatus { initial, loading, loaded, error }

class WatchlistState {
  final WatchlistStatus status;
  final List<Instrument> instruments;
  final String? errorMessage;

  const WatchlistState({
    this.status = WatchlistStatus.initial,
    this.instruments = const [],
    this.errorMessage,
  });

  WatchlistState copyWith({
    WatchlistStatus? status,
    List<Instrument>? instruments,
    String? errorMessage,
  }) {
    return WatchlistState(
      status: status ?? this.status,
      instruments: instruments ?? this.instruments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
