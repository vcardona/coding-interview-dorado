// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Currency Exchange';

  @override
  String get tengo => 'TENHO';

  @override
  String get quiero => 'QUERO';

  @override
  String get amountHint => '0.00';

  @override
  String get estimatedRate => 'Taxa estimada';

  @override
  String get youWillReceive => 'Você receberá';

  @override
  String get estimatedTime => 'Tempo estimado';

  @override
  String get exchangeButton => 'Trocar';

  @override
  String get selectCryptoCurrency => 'Cripto';

  @override
  String get selectFiatCurrency => 'FIAT';

  @override
  String get errorFetchingRate => 'Erro ao obter taxa de câmbio';

  @override
  String serverError(int statusCode) {
    return 'Erro do servidor ($statusCode). Por favor, tente novamente.';
  }

  @override
  String get connectionTimeout =>
      'Tempo de espera esgotado. Verifique sua conexão.';

  @override
  String get connectionError => 'Erro de conexão. Verifique sua rede.';

  @override
  String get invalidAmount => 'Por favor, insira um valor válido';

  @override
  String get noRatesAvailable =>
      'Nenhuma taxa de câmbio disponível para este par de moedas';

  @override
  String get approximateSymbol => '≈';
}
