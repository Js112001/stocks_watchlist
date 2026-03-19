import '../../domain/entities/stock.dart';
import '../../domain/repository/watchlist_repository.dart';
import '../services/stock_api_service.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final StockApiService apiService;
  final List<String> _symbols = ['AAPL', 'GOOGL'];

  WatchlistRepositoryImpl(this.apiService);

  @override
  Future<List<Stock>> getWatchlist() => apiService.fetchStocks(_symbols);

  @override
  Future<void> addStock(String symbol) async => _symbols.add(symbol);

  @override
  Future<void> removeStock(String symbol) async => _symbols.remove(symbol);
}
