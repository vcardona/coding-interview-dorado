import 'package:equatable/equatable.dart';

class ExchangeRateEntity extends Equatable {
  const ExchangeRateEntity({
    required this.rate,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.convertedAmount,
    required this.estimatedTime,
  });

  final double rate;
  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double convertedAmount;
  final String estimatedTime;

  @override
  List<Object?> get props => [
        rate,
        fromCurrency,
        toCurrency,
        amount,
        convertedAmount,
        estimatedTime,
      ];
}
