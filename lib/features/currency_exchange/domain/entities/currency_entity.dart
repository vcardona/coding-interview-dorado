import 'package:equatable/equatable.dart';

enum CurrencyTypeEntity {
  fiat,
  crypto,
}

class CurrencyEntity extends Equatable {
  const CurrencyEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    this.symbol,
    this.iconPath,
  });

  final String id;
  final String code;
  final String name;
  final CurrencyTypeEntity type;
  final String? symbol;
  final String? iconPath;

  @override
  List<Object?> get props => [id, code, name, type, symbol, iconPath];
}
