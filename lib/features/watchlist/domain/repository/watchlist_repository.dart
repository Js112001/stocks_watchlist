import '../entities/instrument.dart';

abstract class WatchlistRepository {
  Future<List<Instrument>> getWatchlist();
}
