import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_rate_response_model.freezed.dart';
part 'exchange_rate_response_model.g.dart';

@freezed
class ExchangeRateResponseModel with _$ExchangeRateResponseModel {
  const factory ExchangeRateResponseModel({
    required ExchangeRateDataModel data,
  }) = _ExchangeRateResponseModel;

  factory ExchangeRateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateResponseModelFromJson(json);
}

@freezed
class ExchangeRateDataModel with _$ExchangeRateDataModel {
  const factory ExchangeRateDataModel({
    ByPriceModel? byPrice,
  }) = _ExchangeRateDataModel;

  factory ExchangeRateDataModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateDataModelFromJson(json);
}

@freezed
class ByPriceModel with _$ByPriceModel {
  const factory ByPriceModel({
    @_ExchangeRateConverter() double? fiatToCryptoExchangeRate,
  }) = _ByPriceModel;

  factory ByPriceModel.fromJson(Map<String, dynamic> json) =>
      _$ByPriceModelFromJson(json);
}

// Custom converter to handle String or num for exchange rate
class _ExchangeRateConverter implements JsonConverter<double?, dynamic> {
  const _ExchangeRateConverter();

  @override
  double? fromJson(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  @override
  dynamic toJson(double? value) => value;
}
