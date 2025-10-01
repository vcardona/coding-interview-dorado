import 'package:coding_interview_dorado/features/currency_exchange/presentation/providers/currency_exchange_provider.dart';
import 'package:coding_interview_dorado/shared/theme/app_colors.dart';
import 'package:coding_interview_dorado/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyExchangePage extends ConsumerWidget {
  const CurrencyExchangePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(currencyExchangeNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Currency Exchange'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Main Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Currency Selector Row - Placeholder
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
                              child: Center(
                                child: state.maybeWhen(
                                  orElse: () => const Text(
                                    'USDT',
                                    style: AppTextStyles.currencyCode,
                                  ),
                                  initial: (from, to, amount) => Text(
                                    from,
                                    style: AppTextStyles.currencyCode,
                                  ),
                                  loading: (from, to, amount) => Text(
                                    from,
                                    style: AppTextStyles.currencyCode,
                                  ),
                                  success: (from, to, amount, rate) => Text(
                                    from,
                                    style: AppTextStyles.currencyCode,
                                  ),
                                  error: (from, to, amount, message) => Text(
                                    from,
                                    style: AppTextStyles.currencyCode,
                                  ),
                                ),
                              ),
                            ),
                            Container(
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
                            Expanded(
                              child: Center(
                                child: state.maybeWhen(
                                  orElse: () => const Text(
                                    'VES',
                                    style: AppTextStyles.currencyCode,
                                  ),
                                  initial: (from, to, amount) => Text(
                                    to,
                                    style: AppTextStyles.currencyCode,
                                  ),
                                  loading: (from, to, amount) => Text(
                                    to,
                                    style: AppTextStyles.currencyCode,
                                  ),
                                  success: (from, to, amount, rate) => Text(
                                    to,
                                    style: AppTextStyles.currencyCode,
                                  ),
                                  error: (from, to, amount, message) => Text(
                                    to,
                                    style: AppTextStyles.currencyCode,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Amount Input - Placeholder
                      TextField(
                        decoration: InputDecoration(
                          hintText: '0.00',
                          prefixText: state.maybeWhen(
                            orElse: () => 'USDT ',
                            initial: (from, to, amount) => '$from ',
                            loading: (from, to, amount) => '$from ',
                            success: (from, to, amount, rate) => '$from ',
                            error: (from, to, amount, message) => '$from ',
                          ),
                          prefixStyle: AppTextStyles.currencyCodeLarge,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: AppTextStyles.amount,
                      ),
                      const SizedBox(height: 24),
                      // Results Section
                      state.maybeWhen(
                        success: (from, to, amount, rate) => Column(
                          children: [
                            _ResultRow(
                              label: 'Tasa estimada',
                              value: '≈ ${rate.rate.toStringAsFixed(2)} $to',
                            ),
                            const SizedBox(height: 16),
                            _ResultRow(
                              label: 'Recibirás',
                              value:
                                  '≈ ${rate.convertedAmount.toStringAsFixed(2)} $to',
                            ),
                            const SizedBox(height: 16),
                            _ResultRow(
                              label: 'Tiempo estimado',
                              value: rate.estimatedTime,
                            ),
                          ],
                        ),
                        loading: (from, to, amount) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (from, to, amount, message) => Text(
                          message,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 32),
                      // Action Button
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(currencyExchangeNotifierProvider.notifier)
                              .getExchangeRate();
                        },
                        child: const Text('Cambiar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium,
        ),
        Text(
          value,
          style: AppTextStyles.bodyLarge,
        ),
      ],
    );
  }
}
