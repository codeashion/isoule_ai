import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_nav_event.dart';
import 'dashboard_nav_state.dart';

class DashboardNavBloc extends Bloc<DashboardNavEvent, DashboardNavState> {
  DashboardNavBloc() : super(const DashboardNavState()) {
    on<DashboardTabSelected>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}
