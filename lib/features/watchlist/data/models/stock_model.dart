import '../../domain/entities/stock.dart';

class StockModel extends Stock {
  const StockModel({
    required super.symbol,
    required super.name,
    required super.price,
    required super.changePercent,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'name': name,
        'price': price,
        'changePercent': changePercent,
      };
}
