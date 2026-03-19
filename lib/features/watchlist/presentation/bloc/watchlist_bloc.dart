import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_watchlist.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

export 'watchlist_event.dart';
export 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist _getWatchlist;

  WatchlistBloc(this._getWatchlist) : super(const WatchlistState()) {
    on<LoadWatchlist>(_onLoadWatchlist);
  }

  Future<void> _onLoadWatchlist(
    LoadWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(state.copyWith(status: WatchlistStatus.loading));
    try {
      final instruments = await _getWatchlist();
      emit(state.copyWith(status: WatchlistStatus.loaded, instruments: instruments));
    } catch (e) {
      emit(state.copyWith(status: WatchlistStatus.error, errorMessage: e.toString()));
    }
  }
}
