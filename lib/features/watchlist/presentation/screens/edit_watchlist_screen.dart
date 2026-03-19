import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/instrument.dart';
import '../bloc/watchlist_bloc.dart';

class EditWatchlistScreen extends StatefulWidget {
  final int watchlistIndex;

  const EditWatchlistScreen({super.key, required this.watchlistIndex});

  @override
  State<EditWatchlistScreen> createState() => _EditWatchlistScreenState();
}

class _EditWatchlistScreenState extends State<EditWatchlistScreen> {
  List<Instrument> list = [];
  bool _initialized = false;

  String get _watchlistName => 'Watchlist ${widget.watchlistIndex + 1}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit $_watchlistName')),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state.status == WatchlistStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!_initialized && state.status == WatchlistStatus.loaded) {
            list = List.from(state.instruments);
            _initialized = true;
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_watchlistName, style: const TextStyle(fontSize: 18)),
                    const Icon(Icons.edit),
                  ],
                ),
              ),
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: list.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex--;
                      final item = list.removeAt(oldIndex);
                      list.insert(newIndex, item);
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return ListTile(
                      key: ValueKey('${item.name}_$index'),
                      leading: const Icon(Icons.drag_handle),
                      title: Text(item.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => setState(() => list.removeAt(index)),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.grey.shade300,
                      ),
                      child: const Text('Edit other watchlists', style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text('Save Watchlist'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
