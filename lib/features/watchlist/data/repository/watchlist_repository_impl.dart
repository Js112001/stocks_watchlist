import 'package:stocks_watchlist/features/watchlist/data/services/stock_api_service.dart';
import 'package:stocks_watchlist/features/watchlist/domain/entities/instrument.dart';
import 'package:stocks_watchlist/features/watchlist/domain/repository/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final StockApiService apiService;

  WatchlistRepositoryImpl(this.apiService);

  @override
  Future<List<Instrument>> getWatchlist(int watchlistIndex) =>
      apiService.fetchInstruments(watchlistIndex);
}
