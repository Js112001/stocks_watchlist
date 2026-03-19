import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_watchlist/di/service_locator.dart';
import 'package:stocks_watchlist/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:stocks_watchlist/features/watchlist/presentation/screens/watchlist_screen.dart';
import 'package:stocks_watchlist/utils/app_constants.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<WatchlistBloc>()
            ..add(LoadWatchlist(0))
            ..add(LoadWatchlist(1))
            ..add(LoadWatchlist(2)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appTitle,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const WatchlistScreen(),
      ),
    );
  }
}
