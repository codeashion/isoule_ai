import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoule_ai/features/home_screen/presentation/models/memory_item.dart';

import 'add_memory_event.dart';
import 'add_memory_state.dart';

class AddMemoryBloc extends Bloc<AddMemoryEvent, AddMemoryState> {
  AddMemoryBloc() : super(AddMemoryState(dateTime: DateTime.now())) {
    on<MemoryTextChanged>(_onTextChanged);
    on<MemoryDateTimeChanged>(_onDateTimeChanged);
    on<SaveMemoryRequested>(_onSaveRequested);
  }

  void _onTextChanged(MemoryTextChanged event, Emitter<AddMemoryState> emit) {
    emit(state.copyWith(text: event.text, error: null));
  }

  void _onDateTimeChanged(
    MemoryDateTimeChanged event,
    Emitter<AddMemoryState> emit,
  ) {
    emit(state.copyWith(dateTime: event.dateTime, error: null));
  }

  Future<void> _onSaveRequested(
    SaveMemoryRequested event,
    Emitter<AddMemoryState> emit,
  ) async {
    final trimmed = state.text.trim();
    if (trimmed.isEmpty) {
      emit(
        state.copyWith(error: 'Please write something to save your memory.'),
      );
      return;
    }

    emit(state.copyWith(isSaving: true, error: null));

    // Simulate save latency (e.g., writing to local DB or cloud)
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final item = MemoryItem(
      title: trimmed,
      subtitle: '${_formatDateTime(state.dateTime)}',
    );

    emit(state.copyWith(isSaving: false, result: item));
  }

  String _formatDateTime(DateTime dateTime) {
    // Only show date / time in a short style.
    final date =
        '${_weekdayLabel(dateTime.weekday)}, ${_monthLabel(dateTime.month)} ${dateTime.day}';
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final ampm = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$date · ${hour == 0 ? 12 : hour}:$minute $ampm';
  }

  String _weekdayLabel(int weekday) {
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return labels[weekday - 1];
  }

  String _monthLabel(int month) {
    const labels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return labels[month - 1];
  }
}
