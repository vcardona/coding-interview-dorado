import 'package:coding_interview_dorado/l10n/app_localizations.dart';
import 'package:coding_interview_dorado/shared/theme/app_colors.dart';
import 'package:coding_interview_dorado/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CurrencySelectorWidget extends StatelessWidget {
  const CurrencySelectorWidget({
    required this.fromCurrency,
    required this.toCurrency,
    required this.onFromCurrencyTap,
    required this.onToCurrencyTap,
    required this.onSwap,
    super.key,
  });

  final String fromCurrency;
  final String toCurrency;
  final VoidCallback onFromCurrencyTap;
  final VoidCallback onToCurrencyTap;
  final VoidCallback onSwap;

  String _getCurrencyIcon(String currencyCode) {
    final icons = {
      'USDT': 'assets/cripto_currencies/TATUM-TRON-USDT.png',
      'USDC': 'assets/cripto_currencies/USDC.png',
      'VES': 'assets/fiat_currencies/VES.png',
      'COP': 'assets/fiat_currencies/COP.png',
      'PEN': 'assets/fiat_currencies/PEN.png',
      'BRL': 'assets/fiat_currencies/BRL.png',
    };
    return icons[currencyCode] ?? 'assets/fiat_currencies/VES.png';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Labels row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.tengo,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 48), // Space for swap button
              Expanded(
                child: Text(
                  l10n.quiero,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Currency selector
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.borderFocused,
              width: 2,
            ),
          ),
          child: Row(
            children: [
          Expanded(
            child: InkWell(
              onTap: onFromCurrencyTap,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(26),
                bottomLeft: Radius.circular(26),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _getCurrencyIcon(fromCurrency),
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(width: 24, height: 24);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    fromCurrency,
                    style: AppTextStyles.currencyCode,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onSwap,
            customBorder: const CircleBorder(),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.swap_horiz,
                color: AppColors.white,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: onToCurrencyTap,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(26),
                bottomRight: Radius.circular(26),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _getCurrencyIcon(toCurrency),
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(width: 24, height: 24);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    toCurrency,
                    style: AppTextStyles.currencyCode,
                  ),
                ],
              ),
            ),
          ),
            ],
          ),
        ),
      ],
    );
  }
}
