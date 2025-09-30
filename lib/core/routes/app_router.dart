import 'package:coding_interview_dorado/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.home,
  routes: [
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      builder: (context, state) => const _PlaceholderPage(title: 'Home'),
    ),
  ],
);

// Placeholder page - will be replaced with actual pages
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('$title Page - Coming Soon'),
      ),
    );
  }
}
