import 'package:flutter/material.dart';
import '../../domain/entities/instrument.dart';

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
          Text(item.price.toStringAsFixed(2), style: TextStyle(color: color)),
          Text(
            '${item.change.toStringAsFixed(2)} (${item.percent.toStringAsFixed(2)}%)',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
