import 'package:flutter/material.dart';
import 'package:stocks_watchlist/utils/app_constants.dart';

class SortBar extends StatelessWidget {
  const SortBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.sort),
                SizedBox(width: 8),
                Text(AppConstants.sortBy),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
