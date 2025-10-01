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

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Center(
                child: Text(
                  fromCurrency,
                  style: AppTextStyles.currencyCode,
                ),
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
              child: Center(
                child: Text(
                  toCurrency,
                  style: AppTextStyles.currencyCode,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
