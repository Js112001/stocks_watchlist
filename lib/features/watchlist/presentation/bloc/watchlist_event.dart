import 'package:stocks_watchlist/features/watchlist/domain/entities/instrument.dart';

sealed class WatchlistEvent {}

class LoadWatchlist extends WatchlistEvent {
  final int watchlistIndex;

  LoadWatchlist(this.watchlistIndex);
}

class ReorderWatchlist extends WatchlistEvent {
  final int watchlistIndex;
  final List<Instrument> instruments;

  ReorderWatchlist(this.watchlistIndex, this.instruments);
}

class RenameWatchlist extends WatchlistEvent {
  final int watchlistIndex;
  final String name;

  RenameWatchlist(this.watchlistIndex, this.name);
}

class StartEditing extends WatchlistEvent {
  final int watchlistIndex;

  StartEditing(this.watchlistIndex);
}

class ReorderDraft extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderDraft(this.oldIndex, this.newIndex);
}

class DeleteDraftItem extends WatchlistEvent {
  final int index;

  DeleteDraftItem(this.index);
}

class UpdateDraftName extends WatchlistEvent {
  final String name;

  UpdateDraftName(this.name);
}

class SaveDraft extends WatchlistEvent {}
