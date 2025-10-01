class CurrencyConstants {
  CurrencyConstants._();

  static const List<Map<String, String>> fiatCurrencies = [
    {
      'id': 'VES',
      'code': 'VES',
      'name': 'Bolívares (Bs)',
      'icon': 'assets/fiat_currencies/VES.png',
    },
    {
      'id': 'COP',
      'code': 'COP',
      'name': r'Pesos Colombianos (COL$)',
      'icon': 'assets/fiat_currencies/COP.png',
    },
    {
      'id': 'PEN',
      'code': 'PEN',
      'name': 'Soles Peruanos (S/)',
      'icon': 'assets/fiat_currencies/PEN.png',
    },
    {
      'id': 'BRL',
      'code': 'BRL',
      'name': r'Real Brasileño (R$)',
      'icon': 'assets/fiat_currencies/BRL.png',
    },
  ];

  static const List<Map<String, String>> cryptoCurrencies = [
    {
      'id': 'TATUM-TRON-USDT',
      'code': 'USDT',
      'name': 'Tether (USDT)',
      'icon': 'assets/cripto_currencies/TATUM-TRON-USDT.png',
    },
  ];

  /// Get API ID from display code
  static String getApiId(String displayCode) {
    // Check crypto currencies
    for (final crypto in cryptoCurrencies) {
      if (crypto['code'] == displayCode) {
        return crypto['id']!;
      }
    }

    // Check fiat currencies
    for (final fiat in fiatCurrencies) {
      if (fiat['code'] == displayCode) {
        return fiat['id']!;
      }
    }

    // Return the display code if not found
    return displayCode;
  }

  /// Check if currency is crypto
  static bool isCrypto(String displayCode) {
    return cryptoCurrencies.any((crypto) => crypto['code'] == displayCode);
  }
}
