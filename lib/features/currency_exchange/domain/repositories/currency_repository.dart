import 'package:coding_interview_dorado/features/currency_exchange/domain/entities/exchange_rate_entity.dart';

abstract class CurrencyRepository {
  Future<ExchangeRateEntity> getExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  });
}
