import 'package:stocks_watchlist/features/watchlist/data/models/instrument_model.dart';

class StockApiService {
  Future<List<InstrumentModel>> fetchInstruments(int watchlistIndex) async {
    await Future.delayed(const Duration(seconds: 1));
    return switch (watchlistIndex) {
      0 => const [
        InstrumentModel(
          name: 'RELIANCE',
          type: 'NSE | EQ',
          price: 1374.00,
          change: -4.50,
          percent: -0.33,
        ),
        InstrumentModel(
          name: 'HDFCBANK',
          type: 'NSE | EQ',
          price: 966.85,
          change: 0.85,
          percent: 0.09,
        ),
        InstrumentModel(
          name: 'ASIANPAINT',
          type: 'NSE | EQ',
          price: 2537.40,
          change: 6.60,
          percent: 0.26,
        ),
        InstrumentModel(
          name: 'MRF',
          type: 'NSE | EQ',
          price: 147625.00,
          change: 550.00,
          percent: 0.37,
        ),
      ],
      1 => const [
        InstrumentModel(
          name: 'TCS',
          type: 'NSE | EQ',
          price: 3456.70,
          change: 23.40,
          percent: 0.68,
        ),
        InstrumentModel(
          name: 'INFY',
          type: 'NSE | EQ',
          price: 1542.30,
          change: -12.10,
          percent: -0.78,
        ),
        InstrumentModel(
          name: 'WIPRO',
          type: 'NSE | EQ',
          price: 452.15,
          change: 3.25,
          percent: 0.72,
        ),
        InstrumentModel(
          name: 'NIFTY IT',
          type: 'IDX',
          price: 35181.95,
          change: 871.51,
          percent: 2.54,
        ),
      ],
      _ => const [
        InstrumentModel(
          name: 'TATAMOTORS',
          type: 'NSE | EQ',
          price: 654.80,
          change: 8.90,
          percent: 1.38,
        ),
        InstrumentModel(
          name: 'MARUTI',
          type: 'NSE | EQ',
          price: 12450.00,
          change: -85.00,
          percent: -0.68,
        ),
        InstrumentModel(
          name: 'BAJFINANCE',
          type: 'NSE | EQ',
          price: 7234.50,
          change: 45.30,
          percent: 0.63,
        ),
        InstrumentModel(
          name: 'SBIN',
          type: 'NSE | EQ',
          price: 628.40,
          change: -2.10,
          percent: -0.33,
        ),
      ],
    };
  }
}
