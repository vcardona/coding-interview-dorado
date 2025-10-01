import 'package:coding_interview_dorado/core/routes/route_names.dart';
import 'package:coding_interview_dorado/features/currency_exchange/presentation/pages/currency_exchange_page.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.home,
  routes: [
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      builder: (context, state) => const CurrencyExchangePage(),
    ),
  ],
);
