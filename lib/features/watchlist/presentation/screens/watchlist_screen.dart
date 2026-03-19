import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_watchlist/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:stocks_watchlist/features/watchlist/presentation/screens/edit_watchlist_screen.dart';
import 'package:stocks_watchlist/features/watchlist/presentation/widgets/instrument_tile.dart';
import 'package:stocks_watchlist/features/watchlist/presentation/widgets/search_bar.dart';
import 'package:stocks_watchlist/features/watchlist/presentation/widgets/sort_bar.dart';
import 'package:stocks_watchlist/utils/app_constants.dart';

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
        title: const Text(AppConstants.watchlist),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              const WatchlistSearchBar(),
              BlocBuilder<WatchlistBloc, WatchlistState>(
                buildWhen: (prev, curr) => prev.names != curr.names,
                builder: (context, state) {
                  return TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: List.generate(3, (i) => Tab(text: state.nameFor(i))),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(3, (i) => _WatchlistTab(watchlistIndex: i)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final index = _tabController.index;
          context.read<WatchlistBloc>().add(StartEditing(index));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditWatchlistScreen(watchlistIndex: index),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class _WatchlistTab extends StatelessWidget {
  final int watchlistIndex;

  const _WatchlistTab({required this.watchlistIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SortBar(),
        Expanded(
          child: BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) {
              final status = state.statusFor(watchlistIndex);
              final instruments = state.instrumentsFor(watchlistIndex);
              return switch (status) {
                WatchlistStatus.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
                WatchlistStatus.error => Center(
                  child: Text(state.errorMessage ?? AppConstants.error),
                ),
                WatchlistStatus.loaded => ListView.builder(
                  itemCount: instruments.length,
                  itemBuilder: (_, i) => InstrumentTile(item: instruments[i]),
                ),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
      ],
    );
  }
}
