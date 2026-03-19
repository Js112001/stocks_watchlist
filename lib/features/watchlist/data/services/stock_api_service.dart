import '../models/stock_model.dart';

class StockApiService {
  Future<List<StockModel>> fetchStocks(List<String> symbols) async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [
      const StockModel(symbol: 'AAPL', name: 'Apple Inc.', price: 195.50, changePercent: 1.25),
      const StockModel(symbol: 'GOOGL', name: 'Alphabet Inc.', price: 141.80, changePercent: -0.45),
    ];
  }
}
