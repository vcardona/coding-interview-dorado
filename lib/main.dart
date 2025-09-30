import 'package:coding_interview_dorado/app.dart';
import 'package:coding_interview_dorado/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure dependency injection
  await configureDependencies();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
