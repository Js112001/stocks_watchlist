import 'package:flutter/foundation.dart';
import '../../domain/entities/stock.dart';
import '../../domain/usecases/get_watchlist.dart';

enum WatchlistStatus { initial, loading, loaded, error }

class WatchlistState {
  final WatchlistStatus status;
  final List<Stock> stocks;
  final String? errorMessage;

  const WatchlistState({
    this.status = WatchlistStatus.initial,
    this.stocks = const [],
    this.errorMessage,
  });

  WatchlistState copyWith({WatchlistStatus? status, List<Stock>? stocks, String? errorMessage}) {
    return WatchlistState(
      status: status ?? this.status,
      stocks: stocks ?? this.stocks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class WatchlistBloc extends ChangeNotifier {
  final GetWatchlist getWatchlist;
  WatchlistState state = const WatchlistState();

  WatchlistBloc(this.getWatchlist);

  Future<void> loadWatchlist() async {
    state = state.copyWith(status: WatchlistStatus.loading);
    notifyListeners();
    try {
      final stocks = await getWatchlist();
      state = state.copyWith(status: WatchlistStatus.loaded, stocks: stocks);
    } catch (e) {
      state = state.copyWith(status: WatchlistStatus.error, errorMessage: e.toString());
    }
    notifyListeners();
  }
}
