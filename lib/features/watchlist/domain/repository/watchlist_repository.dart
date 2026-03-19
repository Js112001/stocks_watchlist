import '../entities/stock.dart';

abstract class WatchlistRepository {
  Future<List<Stock>> getWatchlist();
  Future<void> addStock(String symbol);
  Future<void> removeStock(String symbol);
}
