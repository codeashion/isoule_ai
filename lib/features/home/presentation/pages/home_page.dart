import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/home_bloc.dart';
import '../../presentation/bloc/home_state.dart';
import '../../presentation/bloc/home_event.dart';
import '../../../../src/shared/widgets/loading_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const LoadingWidget();
          }
          if (state.status == HomeStatus.success) {
            return const Center(child: Text('Home loaded'));
          }
          return Center(
            child: ElevatedButton(
              onPressed: () =>
                  context.read<HomeBloc>().add(const HomeRequested()),
              child: const Text('Load'),
            ),
          );
        },
      ),
    );
  }
}
