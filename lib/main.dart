import 'package:flutter/material.dart';
import 'package:isoule_ai/src/core/di.dart';
import 'package:isoule_ai/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const App());
}
