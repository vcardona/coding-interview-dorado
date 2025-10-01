import 'package:coding_interview_dorado/features/currency_exchange/domain/entities/exchange_rate_entity.dart';
import 'package:coding_interview_dorado/features/currency_exchange/domain/repositories/currency_repository.dart';
import 'package:coding_interview_dorado/features/currency_exchange/domain/usecases/get_exchange_rate_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_exchange_rate_usecase_test.mocks.dart';

@GenerateMocks([CurrencyRepository])
void main() {
  late GetExchangeRateUseCase useCase;
  late MockCurrencyRepository mockRepository;

  setUp(() {
    mockRepository = MockCurrencyRepository();
    useCase = GetExchangeRateUseCase(mockRepository);
  });

  group('GetExchangeRateUseCase', () {
    const tType = 0; // CRYPTO to FIAT
    const tCryptoCurrencyId = 'TATUM-TRON-USDT';
    const tFiatCurrencyId = 'COP';
    const tAmount = 100.0;
    const tAmountCurrencyId = 'TATUM-TRON-USDT';

    const tExchangeRateEntity = ExchangeRateEntity(
      rate: 3800.0,
      fromCurrency: 'TATUM-TRON-USDT',
      toCurrency: 'COP',
      amount: 100.0,
      convertedAmount: 380000.0,
      estimatedTime: '≈ 10 Min',
    );

    test('should get exchange rate from repository', () async {
      // Arrange
      when(
        mockRepository.getExchangeRate(
          type: anyNamed('type'),
          cryptoCurrencyId: anyNamed('cryptoCurrencyId'),
          fiatCurrencyId: anyNamed('fiatCurrencyId'),
          amount: anyNamed('amount'),
          amountCurrencyId: anyNamed('amountCurrencyId'),
        ),
      ).thenAnswer((_) async => tExchangeRateEntity);

      // Act
      final result = await useCase.call(
        type: tType,
        cryptoCurrencyId: tCryptoCurrencyId,
        fiatCurrencyId: tFiatCurrencyId,
        amount: tAmount,
        amountCurrencyId: tAmountCurrencyId,
      );

      // Assert
      expect(result, tExchangeRateEntity);
      verify(
        mockRepository.getExchangeRate(
          type: tType,
          cryptoCurrencyId: tCryptoCurrencyId,
          fiatCurrencyId: tFiatCurrencyId,
          amount: tAmount,
          amountCurrencyId: tAmountCurrencyId,
        ),
      );
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw ArgumentError when amount is zero', () async {
      // Act & Assert
      expect(
        () => useCase.call(
          type: tType,
          cryptoCurrencyId: tCryptoCurrencyId,
          fiatCurrencyId: tFiatCurrencyId,
          amount: 0.0,
          amountCurrencyId: tAmountCurrencyId,
        ),
        throwsA(isA<ArgumentError>()),
      );

      verifyNever(
        mockRepository.getExchangeRate(
          type: any,
          cryptoCurrencyId: any,
          fiatCurrencyId: any,
          amount: any,
          amountCurrencyId: any,
        ),
      );
    });

    test('should throw ArgumentError when amount is negative', () async {
      // Act & Assert
      expect(
        () => useCase.call(
          type: tType,
          cryptoCurrencyId: tCryptoCurrencyId,
          fiatCurrencyId: tFiatCurrencyId,
          amount: -10.0,
          amountCurrencyId: tAmountCurrencyId,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError when crypto currency ID is empty',
        () async {
      // Act & Assert
      expect(
        () => useCase.call(
          type: tType,
          cryptoCurrencyId: '',
          fiatCurrencyId: tFiatCurrencyId,
          amount: tAmount,
          amountCurrencyId: tAmountCurrencyId,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError when fiat currency ID is empty',
        () async {
      // Act & Assert
      expect(
        () => useCase.call(
          type: tType,
          cryptoCurrencyId: tCryptoCurrencyId,
          fiatCurrencyId: '',
          amount: tAmount,
          amountCurrencyId: tAmountCurrencyId,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError when type is invalid', () async {
      // Act & Assert
      expect(
        () => useCase.call(
          type: 2, // Invalid type
          cryptoCurrencyId: tCryptoCurrencyId,
          fiatCurrencyId: tFiatCurrencyId,
          amount: tAmount,
          amountCurrencyId: tAmountCurrencyId,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
