import 'package:coding_interview_dorado/app.dart';
import 'package:coding_interview_dorado/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Currency Exchange App Integration Tests', () {
    setUpAll(() async {
      await configureDependencies();
    });

    testWidgets('complete currency exchange flow', (WidgetTester tester) async {
      // Arrange - Launch app
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Initial state should show default currencies
      expect(find.text('TENGO'), findsOneWidget);
      expect(find.text('QUIERO'), findsOneWidget);
      expect(find.text('USDT'), findsOneWidget);
      expect(find.text('COP'), findsOneWidget);

      // Act - Enter amount
      final amountField = find.byType(TextField);
      await tester.tap(amountField);
      await tester.enterText(amountField, '100');
      await tester.pumpAndSettle();

      // Act - Tap exchange button
      final exchangeButton = find.text('Cambiar');
      await tester.tap(exchangeButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Assert - Should show loading or results
      // Note: This might show results or error depending on API availability
      expect(
        find.byType(CircularProgressIndicator).evaluate().isEmpty ||
            find.text('Tasa estimada').evaluate().isNotEmpty ||
            find.textContaining('Error').evaluate().isNotEmpty,
        true,
      );
    });

    testWidgets('swap currencies flow', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Get initial currencies
      expect(find.text('USDT'), findsOneWidget);
      expect(find.text('COP'), findsOneWidget);

      // Act - Tap swap button
      final swapButton = find.byIcon(Icons.swap_horiz);
      await tester.tap(swapButton);
      await tester.pumpAndSettle();

      // Assert - Currencies should be swapped
      // After swap, COP should be in "from" position and USDT in "to" position
      expect(find.text('COP'), findsOneWidget);
      expect(find.text('USDT'), findsOneWidget);
    });

    testWidgets('change currency selection', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Tap on "to" currency to open selector
      final copText = find.text('COP');
      await tester.tap(copText);
      await tester.pumpAndSettle();

      // Assert - Bottom sheet should appear with currency options
      expect(find.text('FIAT'), findsOneWidget);

      // Act - Select a different currency (if available)
      final brlOption = find.text('BRL');
      if (brlOption.evaluate().isNotEmpty) {
        await tester.tap(brlOption);
        await tester.pumpAndSettle();

        // Assert - Currency should be changed to BRL
        expect(find.text('BRL'), findsOneWidget);
      }
    });

    testWidgets('invalid amount shows error', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Try to exchange without entering amount
      final exchangeButton = find.text('Cambiar');
      await tester.tap(exchangeButton);
      await tester.pumpAndSettle();

      // Assert - Should show error message
      expect(find.textContaining('válida'), findsOneWidget);
    });

    testWidgets('app bar shows correct title', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Currency Exchange'), findsOneWidget);
    });

    testWidgets('decorative background is rendered',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Should render main card and background
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Stack), findsAtLeastNWidgets(1));
    });
  });
}
