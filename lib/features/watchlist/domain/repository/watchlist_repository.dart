import 'package:stocks_watchlist/features/watchlist/domain/entities/instrument.dart';

abstract class WatchlistRepository {
  Future<List<Instrument>> getWatchlist(int watchlistIndex);
}
