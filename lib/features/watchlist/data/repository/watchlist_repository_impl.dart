import '../../domain/entities/instrument.dart';
import '../../domain/repository/watchlist_repository.dart';
import '../services/stock_api_service.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final StockApiService apiService;

  WatchlistRepositoryImpl(this.apiService);

  @override
  Future<List<Instrument>> getWatchlist() => apiService.fetchInstruments();
}
