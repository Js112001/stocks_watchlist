import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_watchlist/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:stocks_watchlist/utils/app_constants.dart';
import 'package:stocks_watchlist/utils/app_textstyle.dart';

class EditWatchlistScreen extends StatelessWidget {
  final int watchlistIndex;

  const EditWatchlistScreen({super.key, required this.watchlistIndex});

  void _showRenameDialog(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppConstants.renameWatchlist),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: AppConstants.enterWatchlistName,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppConstants.cancel),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                context.read<WatchlistBloc>().add(UpdateDraftName(name));
              }
              Navigator.pop(ctx);
            },
            child: const Text(AppConstants.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        final draft = state.editDraft;
        if (draft == null) {
          return Scaffold(
            appBar: AppBar(title: Text('${AppConstants.editPrefix} ${state.nameFor(watchlistIndex)}')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('${AppConstants.editPrefix} ${draft.name}'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(draft.name, style: AppTextStyle.heading),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showRenameDialog(context, draft.name),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: draft.instruments.length,
                  onReorder: (oldIndex, newIndex) {
                    context.read<WatchlistBloc>().add(ReorderDraft(oldIndex, newIndex));
                  },
                  itemBuilder: (context, index) {
                    final item = draft.instruments[index];
                    return ListTile(
                      key: ValueKey('${item.name}_$index'),
                      leading: const Icon(Icons.drag_handle),
                      title: Text(item.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<WatchlistBloc>().add(DeleteDraftItem(index));
                        },
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        AppConstants.editOtherWatchlists,
                        style: AppTextStyle.buttonBlack,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WatchlistBloc>().add(SaveDraft());
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        AppConstants.saveWatchlist,
                        style: AppTextStyle.buttonWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
