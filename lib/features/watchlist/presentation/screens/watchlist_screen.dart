import 'package:flutter/material.dart';
import '../bloc/watchlist_bloc.dart';
import '../widgets/stock_tile.dart';

class WatchlistScreen extends StatefulWidget {
  final WatchlistBloc bloc;

  const WatchlistScreen({super.key, required this.bloc});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    widget.bloc.addListener(_onStateChange);
    widget.bloc.loadWatchlist();
  }

  void _onStateChange() => setState(() {});

  @override
  void dispose() {
    widget.bloc.removeListener(_onStateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.bloc.state;
    return Scaffold(
      appBar: AppBar(title: const Text('Watchlist')),
      body: switch (state.status) {
        WatchlistStatus.loading => const Center(child: CircularProgressIndicator()),
        WatchlistStatus.error => Center(child: Text(state.errorMessage ?? 'Error')),
        WatchlistStatus.loaded => ListView.builder(
            itemCount: state.stocks.length,
            itemBuilder: (_, i) => StockTile(stock: state.stocks[i]),
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
