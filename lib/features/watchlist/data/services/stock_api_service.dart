import '../models/instrument_model.dart';

class StockApiService {
  Future<List<InstrumentModel>> fetchInstruments() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return const [
      InstrumentModel(name: 'RELIANCE SEP 1370 PE', type: 'NSE | Monthly', price: 19.20, change: 1.00, percent: 5.49),
      InstrumentModel(name: 'HDFCBANK', type: 'NSE | EQ', price: 966.85, change: 0.85, percent: 0.09),
      InstrumentModel(name: 'ASIANPAINT', type: 'NSE | EQ', price: 2537.40, change: 6.60, percent: 0.26),
      InstrumentModel(name: 'RELIANCE SEP 1880 CE', type: 'NSE | Monthly', price: 0.00, change: 0.00, percent: 0.00),
      InstrumentModel(name: 'RELIANCE', type: 'NSE | EQ', price: 1374.00, change: -4.50, percent: -0.33),
      InstrumentModel(name: 'NIFTY IT', type: 'IDX', price: 35181.95, change: 871.51, percent: 2.54),
      InstrumentModel(name: 'MRF', type: 'NSE | EQ', price: 147625.00, change: 550.00, percent: 0.37),
      InstrumentModel(name: 'MRF', type: 'BSE | EQ', price: 147439.45, change: 463.80, percent: 0.32),
    ];
  }
}
