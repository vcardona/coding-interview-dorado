import 'package:coding_interview_dorado/features/currency_exchange/domain/entities/exchange_rate_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeRateEntity', () {
    test('should create an entity with valid data', () {
      // Arrange & Act
      const entity = ExchangeRateEntity(
        rate: 3800.0,
        fromCurrency: 'USDT',
        toCurrency: 'COP',
        amount: 100.0,
        convertedAmount: 380000.0,
        estimatedTime: '≈ 10 Min',
      );

      // Assert
      expect(entity.rate, 3800.0);
      expect(entity.fromCurrency, 'USDT');
      expect(entity.toCurrency, 'COP');
      expect(entity.amount, 100.0);
      expect(entity.convertedAmount, 380000.0);
      expect(entity.estimatedTime, '≈ 10 Min');
    });

    test('should support value equality', () {
      // Arrange
      const entity1 = ExchangeRateEntity(
        rate: 3800.0,
        fromCurrency: 'USDT',
        toCurrency: 'COP',
        amount: 100.0,
        convertedAmount: 380000.0,
        estimatedTime: '≈ 10 Min',
      );

      const entity2 = ExchangeRateEntity(
        rate: 3800.0,
        fromCurrency: 'USDT',
        toCurrency: 'COP',
        amount: 100.0,
        convertedAmount: 380000.0,
        estimatedTime: '≈ 10 Min',
      );

      // Assert
      expect(entity1, equals(entity2));
    });

    test('should not be equal when values differ', () {
      // Arrange
      const entity1 = ExchangeRateEntity(
        rate: 3800.0,
        fromCurrency: 'USDT',
        toCurrency: 'COP',
        amount: 100.0,
        convertedAmount: 380000.0,
        estimatedTime: '≈ 10 Min',
      );

      const entity2 = ExchangeRateEntity(
        rate: 3850.0, // Different rate
        fromCurrency: 'USDT',
        toCurrency: 'COP',
        amount: 100.0,
        convertedAmount: 385000.0,
        estimatedTime: '≈ 10 Min',
      );

      // Assert
      expect(entity1, isNot(equals(entity2)));
    });
  });
}
