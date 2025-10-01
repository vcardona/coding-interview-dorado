// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Currency Exchange';

  @override
  String get tengo => 'TENGO';

  @override
  String get quiero => 'QUIERO';

  @override
  String get amountHint => '0.00';

  @override
  String get estimatedRate => 'Tasa estimada';

  @override
  String get youWillReceive => 'Recibirás';

  @override
  String get estimatedTime => 'Tiempo estimado';

  @override
  String get exchangeButton => 'Cambiar';

  @override
  String get selectCryptoCurrency => 'Cripto';

  @override
  String get selectFiatCurrency => 'FIAT';

  @override
  String get errorFetchingRate => 'Error al obtener la tasa de cambio';

  @override
  String serverError(int statusCode) {
    return 'Error del servidor ($statusCode). Por favor intenta de nuevo.';
  }

  @override
  String get connectionTimeout =>
      'Tiempo de espera agotado. Verifica tu conexión.';

  @override
  String get connectionError => 'Error de conexión. Verifica tu red.';

  @override
  String get invalidAmount => 'Por favor ingresa una cantidad válida';

  @override
  String get noRatesAvailable =>
      'No hay tasas de cambio disponibles para esta combinación de monedas';

  @override
  String get approximateSymbol => '≈';
}
