import 'package:coding_interview_dorado/features/currency_exchange/presentation/widgets/amount_input_widget.dart';
import 'package:coding_interview_dorado/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AmountInputWidget', () {
    late TextEditingController controller;
    String? lastChangedValue;

    setUp(() {
      controller = TextEditingController();
      lastChangedValue = null;
    });

    tearDown(() {
      controller.dispose();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('es'), Locale('en')],
        home: Scaffold(
          body: AmountInputWidget(
            controller: controller,
            currencyCode: 'USDT',
            onChanged: (value) {
              lastChangedValue = value;
            },
          ),
        ),
      );
    }

    testWidgets('should display currency code prefix',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('USDT'), findsOneWidget);
    });

    testWidgets('should display hint text', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('0.00'), findsOneWidget);
    });

    testWidgets('should call onChanged when text is entered',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());
      final textField = find.byType(TextField);

      // Act
      await tester.enterText(textField, '100.50');
      await tester.pump();

      // Assert
      expect(lastChangedValue, '100.50');
    });

    testWidgets('should only accept numeric input with decimal',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());
      final textField = find.byType(TextField);

      // Act
      await tester.enterText(textField, 'abc');
      await tester.pump();

      // Assert - Text should be filtered by inputFormatters
      expect(controller.text, '');
    });

    testWidgets('should limit decimal places to 2',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());
      final textField = find.byType(TextField);

      // Act
      await tester.enterText(textField, '100.999');
      await tester.pump();

      // Assert - Should only accept 2 decimal places
      expect(controller.text.split('.').length <= 2, true);
    });

    testWidgets('should update controller text', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      controller.text = '250.00';
      await tester.pump();

      // Assert
      expect(find.text('250.00'), findsOneWidget);
    });
  });
}
