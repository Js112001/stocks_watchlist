import '../../domain/entities/instrument.dart';

class InstrumentModel extends Instrument {
  const InstrumentModel({
    required String name,
    required String type,
    required double price,
    required double change,
    required double percent,
  }) : super(name, type, price, change, percent);

  factory InstrumentModel.fromJson(Map<String, dynamic> json) {
    return InstrumentModel(
      name: json['name'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      percent: (json['percent'] as num).toDouble(),
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
