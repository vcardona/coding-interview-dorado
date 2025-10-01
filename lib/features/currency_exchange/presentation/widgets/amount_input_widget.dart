import 'package:coding_interview_dorado/l10n/app_localizations.dart';
import 'package:coding_interview_dorado/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInputWidget extends StatelessWidget {
  const AmountInputWidget({
    required this.controller,
    required this.currencyCode,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final String currencyCode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: l10n.amountHint,
        prefix: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            currencyCode,
            style: AppTextStyles.currencyCodeLarge,
          ),
        ),
      ),
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      style: AppTextStyles.amount,
      onChanged: onChanged,
    );
  }
}
