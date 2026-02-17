import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di.dart';
import 'shared/theme/app_theme.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'isoule_ai',
      theme: AppTheme.light(),
      home: BlocProvider(
        create: (_) => HomeBloc()..add(HomeRequested()),
        child: const HomePage(),
      ),
    );
  }
}
