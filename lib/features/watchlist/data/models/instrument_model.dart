import 'package:stocks_watchlist/features/watchlist/domain/entities/instrument.dart';

class InstrumentModel extends Instrument {
  const InstrumentModel({
    required super.name,
    required super.type,
    required super.price,
    required super.change,
    required super.percent,
  });

  factory InstrumentModel.fromJson(Map<String, dynamic> json) {
    return InstrumentModel(
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      change: (json['change'] as num?)?.toDouble() ?? 0.0,
      percent: (json['percent'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'price': price,
        'change': change,
        'percent': percent,
      };
}
