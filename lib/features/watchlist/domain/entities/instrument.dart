class Instrument {
  final String name;
  final String type;
  final double price;
  final double change;
  final double percent;

  const Instrument({
    required this.name,
    required this.type,
    required this.price,
    required this.change,
    required this.percent,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Instrument &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type &&
          price == other.price &&
          change == other.change &&
          percent == other.percent;

  @override
  int get hashCode => Object.hash(name, type, price, change, percent);

  @override
  String toString() => 'Instrument(name: $name, type: $type, price: $price, change: $change, percent: $percent)';
}
