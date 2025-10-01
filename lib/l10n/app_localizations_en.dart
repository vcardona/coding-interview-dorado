// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Currency Exchange';

  @override
  String get tengo => 'I HAVE';

  @override
  String get quiero => 'I WANT';

  @override
  String get amountHint => '0.00';

  @override
  String get estimatedRate => 'Estimated rate';

  @override
  String get youWillReceive => 'You will receive';

  @override
  String get estimatedTime => 'Estimated time';

  @override
  String get exchangeButton => 'Exchange';

  @override
  String get selectCryptoCurrency => 'Crypto';

  @override
  String get selectFiatCurrency => 'FIAT';

  @override
  String get errorFetchingRate => 'Error fetching exchange rate';

  @override
  String serverError(int statusCode) {
    return 'Server error ($statusCode). Please try again.';
  }

  @override
  String get connectionTimeout => 'Connection timeout. Check your connection.';

  @override
  String get connectionError => 'Connection error. Check your network.';

  @override
  String get invalidAmount => 'Please enter a valid amount';

  @override
  String get noRatesAvailable =>
      'No exchange rates available for this currency pair';

  @override
  String get approximateSymbol => '≈';
}
