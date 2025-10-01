import 'package:coding_interview_dorado/features/currency_exchange/domain/entities/exchange_rate_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_exchange_state.freezed.dart';

@freezed
class CurrencyExchangeState with _$CurrencyExchangeState {
  const factory CurrencyExchangeState.initial({
    @Default('USDT') String fromCurrency,
    @Default('VES') String toCurrency,
    @Default(0.0) double amount,
  }) = _Initial;

  const factory CurrencyExchangeState.loading({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
  }) = _Loading;

  const factory CurrencyExchangeState.success({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required ExchangeRateEntity exchangeRate,
  }) = _Success;

  const factory CurrencyExchangeState.error({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required String message,
  }) = _Error;
}
