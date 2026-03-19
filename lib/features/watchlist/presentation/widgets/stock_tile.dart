import 'package:flutter/material.dart';
import '../../domain/entities/stock.dart';

class StockTile extends StatelessWidget {
  final Stock stock;

  const StockTile({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final isPositive = stock.changePercent >= 0;
    return ListTile(
      title: Text(stock.symbol),
      subtitle: Text(stock.name),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('\$${stock.price.toStringAsFixed(2)}'),
          Text(
            '${isPositive ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
            style: TextStyle(color: isPositive ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }
}
