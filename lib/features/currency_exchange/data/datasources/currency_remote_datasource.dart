import 'package:coding_interview_dorado/features/currency_exchange/data/datasources/currency_api_client.dart';
import 'package:coding_interview_dorado/features/currency_exchange/data/models/exchange_rate_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class CurrencyRemoteDataSource {
  Future<ExchangeRateResponseModel> getExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  });
}

@LazySingleton(as: CurrencyRemoteDataSource)
class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  CurrencyRemoteDataSourceImpl(this._apiClient);

  final CurrencyApiClient _apiClient;

  @override
  Future<ExchangeRateResponseModel> getExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  }) async {
    try {
      return await _apiClient.getExchangeRate(
        type: type,
        cryptoCurrencyId: cryptoCurrencyId,
        fiatCurrencyId: fiatCurrencyId,
        amount: amount,
        amountCurrencyId: amountCurrencyId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
