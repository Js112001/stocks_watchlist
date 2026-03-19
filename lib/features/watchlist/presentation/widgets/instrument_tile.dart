import 'package:flutter/material.dart';
import 'package:stocks_watchlist/features/watchlist/domain/entities/instrument.dart';
import 'package:stocks_watchlist/utils/app_textstyle.dart';

class InstrumentTile extends StatelessWidget {
  final Instrument item;

  const InstrumentTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isPositive = item.change >= 0;
    final color = isPositive ? Colors.green : Colors.red;

    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.type),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(item.price.toStringAsFixed(2), style: AppTextStyle.price(color)),
          Text(
            '${item.change.toStringAsFixed(2)} (${item.percent.toStringAsFixed(2)}%)',
            style: AppTextStyle.caption,
          ),
        ],
      ),
    );
  }
}
