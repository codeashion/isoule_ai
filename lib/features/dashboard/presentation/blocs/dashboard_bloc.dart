import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/memory_item.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<LoadDashboard>((event, emit) {
      emit(state.copyWith(memories: _sampleMemories));
    });

    on<AddMemory>((event, emit) {
      emit(state.copyWith(memories: [event.memory, ...state.memories]));
    });
  }
}

const _sampleMemories = [
  MemoryItem(
    title:
        'Spent the afternoon reading at the park. The weather was perfect and...',
    subtitle: 'Today, 2:30 PM',
    type: MemoryType.text,
  ),
  MemoryItem(
    title: 'Voice note: Morning thoughts',
    subtitle: 'Yesterday, 8:15 AM',
    type: MemoryType.voice,
  ),
  MemoryItem(
    title: 'Coffee shop visit with friends',
    subtitle: 'Feb 10, 2025',
    type: MemoryType.image,
  ),
];
