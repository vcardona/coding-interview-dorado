import 'package:coding_interview_dorado/features/currency_exchange/presentation/providers/currency_exchange_provider.dart';
import 'package:coding_interview_dorado/features/currency_exchange/presentation/widgets/amount_input_widget.dart';
import 'package:coding_interview_dorado/features/currency_exchange/presentation/widgets/currency_bottom_sheet.dart';
import 'package:coding_interview_dorado/features/currency_exchange/presentation/widgets/currency_selector_widget.dart';
import 'package:coding_interview_dorado/shared/theme/app_colors.dart';
import 'package:coding_interview_dorado/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyExchangePage extends ConsumerStatefulWidget {
  const CurrencyExchangePage({super.key});

  @override
  ConsumerState<CurrencyExchangePage> createState() =>
      _CurrencyExchangePageState();
}

class _CurrencyExchangePageState extends ConsumerState<CurrencyExchangePage> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(currencyExchangeNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Currency Exchange'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Currency Selector
                      state.maybeWhen(
                        orElse: () => CurrencySelectorWidget(
                          fromCurrency: 'USDT',
                          toCurrency: 'VES',
                          onFromCurrencyTap: _showFromCurrencyPicker,
                          onToCurrencyTap: _showToCurrencyPicker,
                          onSwap: _handleSwap,
                        ),
                        initial: (from, to, amount) => CurrencySelectorWidget(
                          fromCurrency: from,
                          toCurrency: to,
                          onFromCurrencyTap: () =>
                              _showFromCurrencyPicker(from),
                          onToCurrencyTap: () => _showToCurrencyPicker(to),
                          onSwap: _handleSwap,
                        ),
                        loading: (from, to, amount) => CurrencySelectorWidget(
                          fromCurrency: from,
                          toCurrency: to,
                          onFromCurrencyTap: () =>
                              _showFromCurrencyPicker(from),
                          onToCurrencyTap: () => _showToCurrencyPicker(to),
                          onSwap: _handleSwap,
                        ),
                        success: (from, to, amount, rate) =>
                            CurrencySelectorWidget(
                          fromCurrency: from,
                          toCurrency: to,
                          onFromCurrencyTap: () =>
                              _showFromCurrencyPicker(from),
                          onToCurrencyTap: () => _showToCurrencyPicker(to),
                          onSwap: _handleSwap,
                        ),
                        error: (from, to, amount, message) =>
                            CurrencySelectorWidget(
                          fromCurrency: from,
                          toCurrency: to,
                          onFromCurrencyTap: () =>
                              _showFromCurrencyPicker(from),
                          onToCurrencyTap: () => _showToCurrencyPicker(to),
                          onSwap: _handleSwap,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Amount Input
                      state.maybeWhen(
                        orElse: () => AmountInputWidget(
                          controller: _amountController,
                          currencyCode: 'USDT',
                          onChanged: _handleAmountChanged,
                        ),
                        initial: (from, to, amount) => AmountInputWidget(
                          controller: _amountController,
                          currencyCode: from,
                          onChanged: _handleAmountChanged,
                        ),
                        loading: (from, to, amount) => AmountInputWidget(
                          controller: _amountController,
                          currencyCode: from,
                          onChanged: _handleAmountChanged,
                        ),
                        success: (from, to, amount, rate) => AmountInputWidget(
                          controller: _amountController,
                          currencyCode: from,
                          onChanged: _handleAmountChanged,
                        ),
                        error: (from, to, amount, message) => AmountInputWidget(
                          controller: _amountController,
                          currencyCode: from,
                          onChanged: _handleAmountChanged,
                        ),
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
      ),
    );
  }

  void _showFromCurrencyPicker([String currentCurrency = 'USDT']) {
    // Determine if current FROM currency is crypto
    final isCrypto = currentCurrency == 'USDT' || currentCurrency == 'USDC';

    CurrencyBottomSheet.show(
      context: context,
      title: 'Selecciona moneda de origen',
      isCrypto: isCrypto,
      selectedCurrency: currentCurrency,
      onCurrencySelected: (currency) {
        ref
            .read(currencyExchangeNotifierProvider.notifier)
            .setFromCurrency(currency);
      },
    );
  }

  void _showToCurrencyPicker([String currentCurrency = 'VES']) {
    // Determine if current TO currency is crypto
    final isCrypto = currentCurrency == 'USDT' || currentCurrency == 'USDC';

    CurrencyBottomSheet.show(
      context: context,
      title: 'Selecciona moneda de destino',
      isCrypto: isCrypto,
      selectedCurrency: currentCurrency,
      onCurrencySelected: (currency) {
        ref
            .read(currencyExchangeNotifierProvider.notifier)
            .setToCurrency(currency);
      },
    );
  }

  void _handleSwap() {
    ref.read(currencyExchangeNotifierProvider.notifier).swapCurrencies();
  }

  void _handleAmountChanged(String value) {
    final amount = double.tryParse(value) ?? 0.0;
    ref.read(currencyExchangeNotifierProvider.notifier).setAmount(amount);
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
