import 'package:stocks_watchlist/features/watchlist/domain/entities/instrument.dart';
import 'package:stocks_watchlist/features/watchlist/domain/repository/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository repository;

  GetWatchlist(this.repository);

  Future<List<Instrument>> call(int watchlistIndex) =>
      repository.getWatchlist(watchlistIndex);
}
