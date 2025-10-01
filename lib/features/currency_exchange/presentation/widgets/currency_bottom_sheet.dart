import 'package:coding_interview_dorado/core/constants/currency_constants.dart';
import 'package:coding_interview_dorado/shared/theme/app_colors.dart';
import 'package:coding_interview_dorado/shared/theme/app_spacing.dart';
import 'package:coding_interview_dorado/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CurrencyBottomSheet extends StatelessWidget {
  const CurrencyBottomSheet({
    required this.title,
    required this.currencies,
    required this.selectedCurrency,
    required this.onCurrencySelected,
    super.key,
  });

  final String title;
  final List<Map<String, String>> currencies;
  final String selectedCurrency;
  final ValueChanged<String> onCurrencySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              title,
              style: AppTextStyles.headline,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];
                final code = currency['code']!;
                final name = currency['name']!;
                final icon = currency['icon']!;
                final isSelected = code == selectedCurrency;

                return ListTile(
                  onTap: () {
                    onCurrencySelected(code);
                    Navigator.pop(context);
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  leading: Image.asset(
                    icon,
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                  ),
                  title: Text(
                    code,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  trailing: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: 2,
                      ),
                      color: isSelected ? AppColors.primary : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: AppColors.white,
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String title,
    required bool isCrypto,
    required String selectedCurrency,
    required ValueChanged<String> onCurrencySelected,
  }) {
    final currencies = isCrypto
        ? CurrencyConstants.cryptoCurrencies
        : CurrencyConstants.fiatCurrencies;

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CurrencyBottomSheet(
        title: title,
        currencies: currencies,
        selectedCurrency: selectedCurrency,
        onCurrencySelected: onCurrencySelected,
      ),
    );
  }
}
