import 'package:flutter/material.dart';
import 'package:stocks_watchlist/utils/app_constants.dart';

class WatchlistSearchBar extends StatelessWidget {
  const WatchlistSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppConstants.searchHint,
          prefixIcon: const Icon(Icons.search),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
