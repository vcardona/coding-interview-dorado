import 'package:coding_interview_dorado/features/currency_exchange/domain/entities/exchange_rate_entity.dart';
import 'package:coding_interview_dorado/features/currency_exchange/domain/usecases/get_exchange_rate_usecase.dart';
import 'package:coding_interview_dorado/features/currency_exchange/presentation/providers/currency_exchange_provider.dart';
import 'package:coding_interview_dorado/features/currency_exchange/presentation/state/currency_exchange_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_exchange_provider_test.mocks.dart';

@GenerateMocks([GetExchangeRateUseCase])
void main() {
  late MockGetExchangeRateUseCase mockGetExchangeRateUseCase;
  late ProviderContainer container;

  setUp(() {
    mockGetExchangeRateUseCase = MockGetExchangeRateUseCase();
    container = ProviderContainer(
      overrides: [
        getExchangeRateUseCaseProvider
            .overrideWithValue(mockGetExchangeRateUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('CurrencyExchangeNotifier', () {
    test('initial state should be CurrencyExchangeState.initial', () {
      // Arrange & Act
      final state = container.read(currencyExchangeNotifierProvider);

      // Assert
      expect(state, isA<CurrencyExchangeState>());
      state.maybeWhen(
        initial: (from, to, amount) {
          expect(from, 'USDT');
          expect(to, 'COP');
          expect(amount, 0.0);
        },
        orElse: () => fail('Expected initial state'),
      );
    });

    test('setFromCurrency should update fromCurrency', () {
      // Arrange
      final notifier =
          container.read(currencyExchangeNotifierProvider.notifier);

      // Act
      notifier.setFromCurrency('USDC');

      // Assert
      final state = container.read(currencyExchangeNotifierProvider);
      state.maybeWhen(
        initial: (from, to, amount) {
          expect(from, 'USDC');
        },
        orElse: () => fail('Expected initial state'),
      );
    });

    test('setToCurrency should update toCurrency', () {
      // Arrange
      final notifier =
          container.read(currencyExchangeNotifierProvider.notifier);

      // Act
      notifier.setToCurrency('BRL');

      // Assert
      final state = container.read(currencyExchangeNotifierProvider);
      state.maybeWhen(
        initial: (from, to, amount) {
          expect(to, 'BRL');
        },
        orElse: () => fail('Expected initial state'),
      );
    });

    test('setAmount should update amount', () {
      // Arrange
      final notifier =
          container.read(currencyExchangeNotifierProvider.notifier);

      // Act
      notifier.setAmount(100.0);

      // Assert
      final state = container.read(currencyExchangeNotifierProvider);
      state.maybeWhen(
        initial: (from, to, amount) {
          expect(amount, 100.0);
        },
        orElse: () => fail('Expected initial state'),
      );
    });

    test('swapCurrencies should swap fromCurrency and toCurrency', () {
      // Arrange
      final notifier =
          container.read(currencyExchangeNotifierProvider.notifier);
      notifier.setFromCurrency('USDT');
      notifier.setToCurrency('COP');

      // Act
      notifier.swapCurrencies();

      // Assert
      final state = container.read(currencyExchangeNotifierProvider);
      state.maybeWhen(
        initial: (from, to, amount) {
          expect(from, 'COP');
          expect(to, 'USDT');
        },
        orElse: () => fail('Expected initial state'),
      );
    });

    test('getExchangeRate should return error when amount is 0', () async {
      // Arrange
      final notifier =
          container.read(currencyExchangeNotifierProvider.notifier);
      notifier.setAmount(0.0);

      // Act
      await notifier.getExchangeRate();

      // Assert
      final state = container.read(currencyExchangeNotifierProvider);
      state.maybeWhen(
        error: (from, to, amount, message) {
          expect(message, contains('válida'));
        },
        orElse: () => fail('Expected error state'),
      );

      verifyNever(
        mockGetExchangeRateUseCase.call(
          type: any,
          cryptoCurrencyId: any,
          fiatCurrencyId: any,
          amount: any,
          amountCurrencyId: any,
        ),
      );
    });

    test('getExchangeRate should emit loading and success states', () async {
      // Arrange
      const tExchangeRateEntity = ExchangeRateEntity(
        rate: 3800.0,
        fromCurrency: 'TATUM-TRON-USDT',
        toCurrency: 'COP',
        amount: 100.0,
        convertedAmount: 380000.0,
        estimatedTime: '≈ 10 Min',
      );

      when(
        mockGetExchangeRateUseCase.call(
          type: anyNamed('type'),
          cryptoCurrencyId: anyNamed('cryptoCurrencyId'),
          fiatCurrencyId: anyNamed('fiatCurrencyId'),
          amount: anyNamed('amount'),
          amountCurrencyId: anyNamed('amountCurrencyId'),
        ),
      ).thenAnswer((_) async => tExchangeRateEntity);

      final notifier =
          container.read(currencyExchangeNotifierProvider.notifier);
      notifier.setAmount(100.0);

      // Act
      await notifier.getExchangeRate();

      // Assert
      final state = container.read(currencyExchangeNotifierProvider);
      state.maybeWhen(
        success: (from, to, amount, exchangeRate) {
          expect(from, 'USDT');
          expect(to, 'COP');
          expect(amount, 100.0);
          expect(exchangeRate, tExchangeRateEntity);
        },
        orElse: () => fail('Expected success state'),
      );

      verify(
        mockGetExchangeRateUseCase.call(
          type: 0,
          cryptoCurrencyId: 'TATUM-TRON-USDT',
          fiatCurrencyId: 'COP',
          amount: 100.0,
          amountCurrencyId: 'TATUM-TRON-USDT',
        ),
      ).called(1);
    });

    test('getExchangeRate should emit error state on exception', () async {
      // Arrange
      when(
        mockGetExchangeRateUseCase.call(
          type: anyNamed('type'),
          cryptoCurrencyId: anyNamed('cryptoCurrencyId'),
          fiatCurrencyId: anyNamed('fiatCurrencyId'),
          amount: anyNamed('amount'),
          amountCurrencyId: anyNamed('amountCurrencyId'),
        ),
      ).thenThrow(Exception('Network error'));

      final notifier =
          container.read(currencyExchangeNotifierProvider.notifier);
      notifier.setAmount(100.0);

      // Act
      await notifier.getExchangeRate();

      // Assert
      final state = container.read(currencyExchangeNotifierProvider);
      state.maybeWhen(
        error: (from, to, amount, message) {
          expect(message, isNotEmpty);
        },
        orElse: () => fail('Expected error state'),
      );
    });
  });
}
