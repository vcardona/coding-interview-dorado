import 'package:coding_interview_dorado/features/currency_exchange/domain/entities/exchange_rate_entity.dart';
import 'package:coding_interview_dorado/features/currency_exchange/domain/repositories/currency_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExchangeRateUseCase {
  GetExchangeRateUseCase(this._repository);

  final CurrencyRepository _repository;

  Future<ExchangeRateEntity> call({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  }) async {
    // Validate amount
    if (amount <= 0) {
      throw ArgumentError('Amount must be greater than 0');
    }

    // Validate currency IDs
    if (cryptoCurrencyId.isEmpty || fiatCurrencyId.isEmpty) {
      throw ArgumentError('Currency IDs cannot be empty');
    }

    // Validate type (0 = CRYPTO->FIAT, 1 = FIAT->CRYPTO)
    if (type != 0 && type != 1) {
      throw ArgumentError('Type must be 0 (CRYPTO->FIAT) or 1 (FIAT->CRYPTO)');
    }

    return _repository.getExchangeRate(
      type: type,
      cryptoCurrencyId: cryptoCurrencyId,
      fiatCurrencyId: fiatCurrencyId,
      amount: amount,
      amountCurrencyId: amountCurrencyId,
    );
  }
}
