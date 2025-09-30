import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_model.freezed.dart';
part 'currency_model.g.dart';

enum CurrencyType {
  @JsonValue('FIAT')
  fiat,
  @JsonValue('CRYPTO')
  crypto,
}

@freezed
class CurrencyModel with _$CurrencyModel {
  const factory CurrencyModel({
    required String id,
    required String code,
    required String name,
    required CurrencyType type,
    String? symbol,
    String? iconPath,
  }) = _CurrencyModel;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);
}
