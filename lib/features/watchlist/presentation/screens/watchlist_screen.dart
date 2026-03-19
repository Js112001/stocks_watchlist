import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../widgets/instrument_tile.dart';
import '../widgets/search_bar.dart';
import '../widgets/sort_bar.dart';
import 'edit_watchlist_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: List.generate(3, (i) => Tab(text: 'Watchlist ${i + 1}')),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(3, (_) => const _WatchlistTab()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EditWatchlistScreen(watchlistIndex: _tabController.index),
          ),
        ),
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class _WatchlistTab extends StatelessWidget {
  const _WatchlistTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WatchlistSearchBar(),
        const SortBar(),
        Expanded(
          child: BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) => switch (state.status) {
              WatchlistStatus.loading => const Center(child: CircularProgressIndicator()),
              WatchlistStatus.error => Center(child: Text(state.errorMessage ?? 'Error')),
              WatchlistStatus.loaded => ListView.builder(
                  itemCount: state.instruments.length,
                  itemBuilder: (_, i) => InstrumentTile(item: state.instruments[i]),
                ),
              _ => const SizedBox.shrink(),
            },
          ),
        ),
      ],
    );
  }
}
