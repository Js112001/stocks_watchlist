import 'package:get_it/get_it.dart';
import 'package:stocks_watchlist/features/watchlist/data/repository/watchlist_repository_impl.dart';
import 'package:stocks_watchlist/features/watchlist/data/services/stock_api_service.dart';
import 'package:stocks_watchlist/features/watchlist/domain/repository/watchlist_repository.dart';
import 'package:stocks_watchlist/features/watchlist/domain/usecases/get_watchlist.dart';
import 'package:stocks_watchlist/features/watchlist/presentation/bloc/watchlist_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Services
  sl.registerLazySingleton(() => StockApiService());

  // Repositories
  sl.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetWatchlist(sl()));

  // Blocs
  sl.registerFactory(() => WatchlistBloc(sl()));
}
