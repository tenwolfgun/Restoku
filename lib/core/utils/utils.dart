import 'package:flutter/services.dart' show rootBundle;
import 'package:money2/money2.dart';

class Utils {
  static final Utils _utils = Utils._internal();

  factory Utils() {
    return _utils;
  }

  Utils._internal();

  Future<String> loadAsset() async => rootBundle.loadString('assets/data.json');

  String convertCurrency(int currency) {
    Currency id = Currency.create('ID', 0,
        symbol: 'Rp ', invertSeparators: true, pattern: "S0.000");
    Currencies.register(id);
    Currency nowUseIt = Currencies.find('ID');
    Money cost = Money.fromInt(currency, nowUseIt);
    return cost.toString();
  }
}
