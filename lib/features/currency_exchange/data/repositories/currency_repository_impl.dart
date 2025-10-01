import 'package:coding_interview_dorado/features/currency_exchange/data/datasources/currency_remote_datasource.dart';
import 'package:coding_interview_dorado/features/currency_exchange/domain/entities/exchange_rate_entity.dart';
import 'package:coding_interview_dorado/features/currency_exchange/domain/repositories/currency_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CurrencyRepository)
class CurrencyRepositoryImpl implements CurrencyRepository {
  CurrencyRepositoryImpl(this._remoteDataSource);

  final CurrencyRemoteDataSource _remoteDataSource;

  @override
  Future<ExchangeRateEntity> getExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  }) async {
    try {
      final response = await _remoteDataSource.getExchangeRate(
        type: type,
        cryptoCurrencyId: cryptoCurrencyId,
        fiatCurrencyId: fiatCurrencyId,
        amount: amount,
        amountCurrencyId: amountCurrencyId,
      );

      // Validate response data
      if (response.data.byPrice == null ||
          response.data.byPrice!.fiatToCryptoExchangeRate == null) {
        throw Exception(
          'No hay tasas de cambio disponibles para esta combinación de monedas',
        );
      }

      // Calculate converted amount based on the exchange rate
      final rate = response.data.byPrice!.fiatToCryptoExchangeRate!;
      final convertedAmount = type == 0
          ? amount / rate // CRYPTO to FIAT
          : amount * rate; // FIAT to CRYPTO

      return ExchangeRateEntity(
        rate: rate,
        fromCurrency: type == 0 ? cryptoCurrencyId : fiatCurrencyId,
        toCurrency: type == 0 ? fiatCurrencyId : cryptoCurrencyId,
        amount: amount,
        convertedAmount: convertedAmount,
        estimatedTime: '≈ 10 Min',
      );
    } catch (e) {
      rethrow;
    }
  }
}
