import '../entities/instrument.dart';
import '../repository/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository repository;

  GetWatchlist(this.repository);

  Future<List<Instrument>> call() => repository.getWatchlist();
}
