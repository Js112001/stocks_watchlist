import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/service_locator.dart';
import 'features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'features/watchlist/presentation/screens/watchlist_screen.dart';

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
        BlocProvider(create: (_) => sl<WatchlistBloc>()..add(LoadWatchlist())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stocks Watchlist',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const WatchlistScreen(),
      ),
    );
  }
}
