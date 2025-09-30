import 'package:coding_interview_dorado/core/constants/api_constants.dart';
import 'package:coding_interview_dorado/features/currency_exchange/data/models/exchange_rate_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'currency_api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CurrencyApiClient {
  factory CurrencyApiClient(Dio dio, {String baseUrl}) = _CurrencyApiClient;

  @GET(ApiConstants.recommendations)
  Future<ExchangeRateResponseModel> getExchangeRate({
    @Query('type') required int type,
    @Query('cryptoCurrencyId') required String cryptoCurrencyId,
    @Query('fiatCurrencyId') required String fiatCurrencyId,
    @Query('amount') required double amount,
    @Query('amountCurrencyId') required String amountCurrencyId,
  });
}
