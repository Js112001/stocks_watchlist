import 'package:get_it/get_it.dart';
import '../features/watchlist/data/repository/watchlist_repository_impl.dart';
import '../features/watchlist/data/services/stock_api_service.dart';
import '../features/watchlist/domain/repository/watchlist_repository.dart';
import '../features/watchlist/domain/usecases/get_watchlist.dart';
import '../features/watchlist/presentation/bloc/watchlist_bloc.dart';

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
