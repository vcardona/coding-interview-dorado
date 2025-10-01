import 'package:coding_interview_dorado/features/currency_exchange/presentation/widgets/currency_selector_widget.dart';
import 'package:coding_interview_dorado/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencySelectorWidget', () {
    bool fromCurrencyTapped = false;
    bool toCurrencyTapped = false;
    bool swapTapped = false;

    setUp(() {
      fromCurrencyTapped = false;
      toCurrencyTapped = false;
      swapTapped = false;
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
          body: CurrencySelectorWidget(
            fromCurrency: 'USDT',
            toCurrency: 'COP',
            onFromCurrencyTap: () {
              fromCurrencyTapped = true;
            },
            onToCurrencyTap: () {
              toCurrencyTapped = true;
            },
            onSwap: () {
              swapTapped = true;
            },
          ),
        ),
      );
    }

    testWidgets('should display TENGO and QUIERO labels',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('TENGO'), findsOneWidget);
      expect(find.text('QUIERO'), findsOneWidget);
    });

    testWidgets('should display from and to currencies',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('USDT'), findsOneWidget);
      expect(find.text('COP'), findsOneWidget);
    });

    testWidgets('should display swap button icon',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.swap_horiz), findsOneWidget);
    });

    testWidgets('should call onFromCurrencyTap when from currency is tapped',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.tap(find.text('USDT'));
      await tester.pump();

      // Assert
      expect(fromCurrencyTapped, true);
    });

    testWidgets('should call onToCurrencyTap when to currency is tapped',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.tap(find.text('COP'));
      await tester.pump();

      // Assert
      expect(toCurrencyTapped, true);
    });

    testWidgets('should call onSwap when swap button is tapped',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.tap(find.byIcon(Icons.swap_horiz));
      await tester.pump();

      // Assert
      expect(swapTapped, true);
    });

    testWidgets('should display currency icons when available',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert - Should find Image widgets for currency icons
      expect(find.byType(Image), findsAtLeastNWidgets(2));
    });
  });
}
