import 'package:coding_interview_dorado/core/constants/api_constants.dart';
import 'package:coding_interview_dorado/features/currency_exchange/data/datasources/currency_api_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio() {
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

    // Add logger interceptor for debugging
    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }

  @lazySingleton
  CurrencyApiClient currencyApiClient(Dio dio) => CurrencyApiClient(dio);
}
