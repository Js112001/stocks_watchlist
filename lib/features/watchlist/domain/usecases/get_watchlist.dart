import '../entities/stock.dart';
import '../repository/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository repository;

  GetWatchlist(this.repository);

  Future<List<Stock>> call() => repository.getWatchlist();
}
