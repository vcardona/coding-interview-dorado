import 'package:coding_interview_dorado/features/currency_exchange/data/datasources/currency_remote_datasource.dart';
import 'package:coding_interview_dorado/features/currency_exchange/data/models/exchange_rate_response_model.dart';
import 'package:coding_interview_dorado/features/currency_exchange/data/repositories/currency_repository_impl.dart';
import 'package:coding_interview_dorado/features/currency_exchange/domain/entities/exchange_rate_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_repository_impl_test.mocks.dart';

@GenerateMocks([CurrencyRemoteDataSource])
void main() {
  late CurrencyRepositoryImpl repository;
  late MockCurrencyRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockCurrencyRemoteDataSource();
    repository = CurrencyRepositoryImpl(mockRemoteDataSource);
  });

  group('CurrencyRepositoryImpl', () {
    const tType = 0; // CRYPTO to FIAT
    const tCryptoCurrencyId = 'TATUM-TRON-USDT';
    const tFiatCurrencyId = 'COP';
    const tAmount = 100.0;
    const tAmountCurrencyId = 'TATUM-TRON-USDT';
    const tRate = 3800.0;

    final tResponseModel = ExchangeRateResponseModel(
      data: ExchangeRateDataModel(
        byPrice: ByPriceModel(
          fiatToCryptoExchangeRate: tRate,
        ),
      ),
    );

    test(
        'should return ExchangeRateEntity when remote data source is successful',
        () async {
      // Arrange
      when(
        mockRemoteDataSource.getExchangeRate(
          type: anyNamed('type'),
          cryptoCurrencyId: anyNamed('cryptoCurrencyId'),
          fiatCurrencyId: anyNamed('fiatCurrencyId'),
          amount: anyNamed('amount'),
          amountCurrencyId: anyNamed('amountCurrencyId'),
        ),
      ).thenAnswer((_) async => tResponseModel);

      // Act
      final result = await repository.getExchangeRate(
        type: tType,
        cryptoCurrencyId: tCryptoCurrencyId,
        fiatCurrencyId: tFiatCurrencyId,
        amount: tAmount,
        amountCurrencyId: tAmountCurrencyId,
      );

      // Assert
      expect(result, isA<ExchangeRateEntity>());
      expect(result.rate, tRate);
      expect(result.amount, tAmount);
      expect(result.fromCurrency, tCryptoCurrencyId);
      expect(result.toCurrency, tFiatCurrencyId);
      verify(
        mockRemoteDataSource.getExchangeRate(
          type: tType,
          cryptoCurrencyId: tCryptoCurrencyId,
          fiatCurrencyId: tFiatCurrencyId,
          amount: tAmount,
          amountCurrencyId: tAmountCurrencyId,
        ),
      );
    });

    test('should calculate correct converted amount for CRYPTO to FIAT',
        () async {
      // Arrange
      when(
        mockRemoteDataSource.getExchangeRate(
          type: anyNamed('type'),
          cryptoCurrencyId: anyNamed('cryptoCurrencyId'),
          fiatCurrencyId: anyNamed('fiatCurrencyId'),
          amount: anyNamed('amount'),
          amountCurrencyId: anyNamed('amountCurrencyId'),
        ),
      ).thenAnswer((_) async => tResponseModel);

      // Act
      final result = await repository.getExchangeRate(
        type: 0, // CRYPTO to FIAT
        cryptoCurrencyId: tCryptoCurrencyId,
        fiatCurrencyId: tFiatCurrencyId,
        amount: tAmount,
        amountCurrencyId: tAmountCurrencyId,
      );

      // Assert
      // For CRYPTO to FIAT: convertedAmount = amount / rate
      expect(result.convertedAmount, tAmount / tRate);
    });

    test('should calculate correct converted amount for FIAT to CRYPTO',
        () async {
      // Arrange
      when(
        mockRemoteDataSource.getExchangeRate(
          type: anyNamed('type'),
          cryptoCurrencyId: anyNamed('cryptoCurrencyId'),
          fiatCurrencyId: anyNamed('fiatCurrencyId'),
          amount: anyNamed('amount'),
          amountCurrencyId: anyNamed('amountCurrencyId'),
        ),
      ).thenAnswer((_) async => tResponseModel);

      // Act
      final result = await repository.getExchangeRate(
        type: 1, // FIAT to CRYPTO
        cryptoCurrencyId: tCryptoCurrencyId,
        fiatCurrencyId: tFiatCurrencyId,
        amount: tAmount,
        amountCurrencyId: tFiatCurrencyId,
      );

      // Assert
      // For FIAT to CRYPTO: convertedAmount = amount * rate
      expect(result.convertedAmount, tAmount * tRate);
    });

    test('should throw Exception when response data is null', () async {
      // Arrange
      final emptyResponseModel = ExchangeRateResponseModel(
        data: ExchangeRateDataModel(byPrice: null),
      );

      when(
        mockRemoteDataSource.getExchangeRate(
          type: anyNamed('type'),
          cryptoCurrencyId: anyNamed('cryptoCurrencyId'),
          fiatCurrencyId: anyNamed('fiatCurrencyId'),
          amount: anyNamed('amount'),
          amountCurrencyId: anyNamed('amountCurrencyId'),
        ),
      ).thenAnswer((_) async => emptyResponseModel);

      // Act & Assert
      expect(
        () => repository.getExchangeRate(
          type: tType,
          cryptoCurrencyId: tCryptoCurrencyId,
          fiatCurrencyId: tFiatCurrencyId,
          amount: tAmount,
          amountCurrencyId: tAmountCurrencyId,
        ),
        throwsException,
      );
    });

    test('should throw Exception when exchange rate is null', () async {
      // Arrange
      final invalidResponseModel = ExchangeRateResponseModel(
        data: ExchangeRateDataModel(
          byPrice: ByPriceModel(fiatToCryptoExchangeRate: null),
        ),
      );

      when(
        mockRemoteDataSource.getExchangeRate(
          type: anyNamed('type'),
          cryptoCurrencyId: anyNamed('cryptoCurrencyId'),
          fiatCurrencyId: anyNamed('fiatCurrencyId'),
          amount: anyNamed('amount'),
          amountCurrencyId: anyNamed('amountCurrencyId'),
        ),
      ).thenAnswer((_) async => invalidResponseModel);

      // Act & Assert
      expect(
        () => repository.getExchangeRate(
          type: tType,
          cryptoCurrencyId: tCryptoCurrencyId,
          fiatCurrencyId: tFiatCurrencyId,
          amount: tAmount,
          amountCurrencyId: tAmountCurrencyId,
        ),
        throwsException,
      );
    });
  });
}
