import 'package:coding_interview_dorado/core/constants/api_constants.dart';
import 'package:coding_interview_dorado/core/constants/currency_constants.dart';
import 'package:coding_interview_dorado/features/currency_exchange/data/datasources/currency_api_client.dart';
import 'package:coding_interview_dorado/features/currency_exchange/data/datasources/currency_remote_datasource.dart';
import 'package:coding_interview_dorado/features/currency_exchange/data/repositories/currency_repository_impl.dart';
import 'package:coding_interview_dorado/features/currency_exchange/domain/repositories/currency_repository.dart';
import 'package:coding_interview_dorado/features/currency_exchange/domain/usecases/get_exchange_rate_usecase.dart';
import 'package:coding_interview_dorado/features/currency_exchange/presentation/state/currency_exchange_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'currency_exchange_provider.g.dart';

@riverpod
class CurrencyExchangeNotifier extends _$CurrencyExchangeNotifier {
  @override
  CurrencyExchangeState build() {
    return const CurrencyExchangeState.initial();
  }

  void setFromCurrency(String currency) {
    state.maybeWhen(
      initial: (from, to, amount) {
        state = CurrencyExchangeState.initial(
          fromCurrency: currency,
          toCurrency: to,
          amount: amount,
        );
      },
      success: (from, to, amount, exchangeRate) {
        state = CurrencyExchangeState.initial(
          fromCurrency: currency,
          toCurrency: to,
          amount: amount,
        );
      },
      error: (from, to, amount, message) {
        state = CurrencyExchangeState.initial(
          fromCurrency: currency,
          toCurrency: to,
          amount: amount,
        );
      },
      orElse: () {},
    );
  }

  void setToCurrency(String currency) {
    state.maybeWhen(
      initial: (from, to, amount) {
        state = CurrencyExchangeState.initial(
          fromCurrency: from,
          toCurrency: currency,
          amount: amount,
        );
      },
      success: (from, to, amount, exchangeRate) {
        state = CurrencyExchangeState.initial(
          fromCurrency: from,
          toCurrency: currency,
          amount: amount,
        );
      },
      error: (from, to, amount, message) {
        state = CurrencyExchangeState.initial(
          fromCurrency: from,
          toCurrency: currency,
          amount: amount,
        );
      },
      orElse: () {},
    );
  }

  void setAmount(double amount) {
    state.maybeWhen(
      initial: (from, to, _) {
        state = CurrencyExchangeState.initial(
          fromCurrency: from,
          toCurrency: to,
          amount: amount,
        );
      },
      success: (from, to, _, exchangeRate) {
        state = CurrencyExchangeState.initial(
          fromCurrency: from,
          toCurrency: to,
          amount: amount,
        );
      },
      error: (from, to, _, message) {
        state = CurrencyExchangeState.initial(
          fromCurrency: from,
          toCurrency: to,
          amount: amount,
        );
      },
      orElse: () {},
    );
  }

  void swapCurrencies() {
    state.maybeWhen(
      initial: (from, to, amount) {
        state = CurrencyExchangeState.initial(
          fromCurrency: to,
          toCurrency: from,
          amount: amount,
        );
      },
      success: (from, to, amount, exchangeRate) {
        state = CurrencyExchangeState.initial(
          fromCurrency: to,
          toCurrency: from,
          amount: amount,
        );
      },
      error: (from, to, amount, message) {
        state = CurrencyExchangeState.initial(
          fromCurrency: to,
          toCurrency: from,
          amount: amount,
        );
      },
      orElse: () {},
    );
  }

  Future<void> getExchangeRate() async {
    final currentState = state;

    var fromCurrency = '';
    var toCurrency = '';
    double amount = 0;

    currentState.maybeWhen(
      initial: (from, to, amt) {
        fromCurrency = from;
        toCurrency = to;
        amount = amt;
      },
      success: (from, to, amt, _) {
        fromCurrency = from;
        toCurrency = to;
        amount = amt;
      },
      error: (from, to, amt, _) {
        fromCurrency = from;
        toCurrency = to;
        amount = amt;
      },
      orElse: () {},
    );

    if (amount <= 0) {
      state = CurrencyExchangeState.error(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        amount: amount,
        message: 'Por favor ingresa una cantidad válida',
      );
      return;
    }

    state = CurrencyExchangeState.loading(
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      amount: amount,
    );

    try {
      final useCase = ref.read(getExchangeRateUseCaseProvider);

      // Determine type and currency IDs using CurrencyConstants
      final isFromCrypto = CurrencyConstants.isCrypto(fromCurrency);

      final type = isFromCrypto ? 0 : 1; // 0: CRYPTO->FIAT, 1: FIAT->CRYPTO

      // Get the actual API IDs (e.g., USDT -> TATUM-TRON-USDT)
      final cryptoCurrencyCode = isFromCrypto ? fromCurrency : toCurrency;
      final fiatCurrencyCode = isFromCrypto ? toCurrency : fromCurrency;

      final cryptoCurrencyId = CurrencyConstants.getApiId(cryptoCurrencyCode);
      final fiatCurrencyId = CurrencyConstants.getApiId(fiatCurrencyCode);
      final amountCurrencyId = CurrencyConstants.getApiId(fromCurrency);

      final result = await useCase.call(
        type: type,
        cryptoCurrencyId: cryptoCurrencyId,
        fiatCurrencyId: fiatCurrencyId,
        amount: amount,
        amountCurrencyId: amountCurrencyId,
      );

      state = CurrencyExchangeState.success(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        amount: amount,
        exchangeRate: result,
      );
    } catch (e, stackTrace) {
      // Log the error for debugging
      print('Error getting exchange rate: $e');
      print('Stack trace: $stackTrace');

      var errorMessage = 'Error al obtener la tasa de cambio';

      if (e is DioException) {
        if (e.response != null) {
          errorMessage =
              'Error del servidor (${e.response!.statusCode}). Por favor intenta de nuevo.';
        } else if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          errorMessage = 'Tiempo de espera agotado. Verifica tu conexión.';
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage = 'Error de conexión. Verifica tu red.';
        }
      } else if (e is Exception) {
        // Handle our custom exception from repository
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }

      state = CurrencyExchangeState.error(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        amount: amount,
        message: errorMessage,
      );
    }
  }
}

@riverpod
GetExchangeRateUseCase getExchangeRateUseCase(Ref ref) {
  return GetExchangeRateUseCase(ref.watch(currencyRepositoryProvider));
}

@riverpod
CurrencyRepository currencyRepository(Ref ref) {
  return ref.watch(currencyRepositoryImplProvider);
}

@riverpod
CurrencyRepository currencyRepositoryImpl(Ref ref) {
  return CurrencyRepositoryImpl(ref.watch(currencyRemoteDataSourceProvider));
}

@riverpod
CurrencyRemoteDataSource currencyRemoteDataSource(
  Ref ref,
) {
  return CurrencyRemoteDataSourceImpl(ref.watch(currencyApiClientProvider));
}

@riverpod
CurrencyApiClient currencyApiClient(Ref ref) {
  return CurrencyApiClient(ref.watch(dioProvider));
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(PrettyDioLogger());

  return dio;
}
