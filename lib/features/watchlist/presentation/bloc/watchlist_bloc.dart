import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_watchlist/features/watchlist/domain/usecases/get_watchlist.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

export 'watchlist_event.dart';
export 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist _getWatchlist;

  WatchlistBloc(this._getWatchlist) : super(const WatchlistState()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<ReorderWatchlist>(_onReorderWatchlist);
    on<RenameWatchlist>(_onRenameWatchlist);
    on<StartEditing>(_onStartEditing);
    on<ReorderDraft>(_onReorderDraft);
    on<DeleteDraftItem>(_onDeleteDraftItem);
    on<UpdateDraftName>(_onUpdateDraftName);
    on<SaveDraft>(_onSaveDraft);
  }

  Future<void> _onLoadWatchlist(
    LoadWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    final i = event.watchlistIndex;
    emit(state.copyWith(
      statuses: {...state.statuses, i: WatchlistStatus.loading},
    ));
    try {
      final instruments = await _getWatchlist(i);
      emit(state.copyWith(
        statuses: {...state.statuses, i: WatchlistStatus.loaded},
        watchlists: {...state.watchlists, i: instruments},
      ));
    } catch (e) {
      emit(state.copyWith(
        statuses: {...state.statuses, i: WatchlistStatus.error},
        errorMessage: e.toString(),
      ));
    }
  }

  void _onReorderWatchlist(
    ReorderWatchlist event,
    Emitter<WatchlistState> emit,
  ) {
    emit(state.copyWith(
      watchlists: {...state.watchlists, event.watchlistIndex: event.instruments},
    ));
  }

  void _onRenameWatchlist(
    RenameWatchlist event,
    Emitter<WatchlistState> emit,
  ) {
    emit(state.copyWith(
      names: {...state.names, event.watchlistIndex: event.name},
    ));
  }

  void _onStartEditing(StartEditing event, Emitter<WatchlistState> emit) {
    final i = event.watchlistIndex;
    emit(state.copyWith(
      editDraft: EditDraft(
        watchlistIndex: i,
        instruments: List.from(state.instrumentsFor(i)),
        name: state.nameFor(i),
      ),
    ));
  }

  void _onReorderDraft(ReorderDraft event, Emitter<WatchlistState> emit) {
    final draft = state.editDraft;
    if (draft == null) return;
    final list = List<dynamic>.from(draft.instruments);
    var newIndex = event.newIndex;
    if (newIndex > event.oldIndex) newIndex--;
    final item = list.removeAt(event.oldIndex);
    list.insert(newIndex, item);
    emit(state.copyWith(
      editDraft: draft.copyWith(instruments: list.cast()),
    ));
  }

  void _onDeleteDraftItem(DeleteDraftItem event, Emitter<WatchlistState> emit) {
    final draft = state.editDraft;
    if (draft == null) return;
    final list = List.of(draft.instruments)..removeAt(event.index);
    emit(state.copyWith(editDraft: draft.copyWith(instruments: list)));
  }

  void _onUpdateDraftName(UpdateDraftName event, Emitter<WatchlistState> emit) {
    final draft = state.editDraft;
    if (draft == null) return;
    emit(state.copyWith(editDraft: draft.copyWith(name: event.name)));
  }

  void _onSaveDraft(SaveDraft event, Emitter<WatchlistState> emit) {
    final draft = state.editDraft;
    if (draft == null) return;
    final i = draft.watchlistIndex;
    emit(state.copyWith(
      watchlists: {...state.watchlists, i: draft.instruments},
      names: {...state.names, i: draft.name},
      clearDraft: true,
    ));
  }
}
