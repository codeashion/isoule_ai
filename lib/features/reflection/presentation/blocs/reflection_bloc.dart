import 'package:flutter_bloc/flutter_bloc.dart';
import 'reflection_event.dart';
import 'reflection_state.dart';

class ReflectionBloc extends Bloc<ReflectionEvent, ReflectionState> {
  ReflectionBloc() : super(const ReflectionState()) {
    on<ReflectionMoodSelected>((event, emit) {
      emit(state.copyWith(selectedMood: event.moodIndex));
    });

    on<ReflectionTextChanged>((event, emit) {
      emit(state.copyWith(reflectionText: event.text));
    });

    on<ReflectionSaveRequested>((event, emit) async {
      if (state.reflectionText.trim().isEmpty) {
        // Nothing to save, just keep current state.
        return;
      }

      emit(state.copyWith(isSaving: true, isSaved: false));
      await Future.delayed(const Duration(milliseconds: 400));
      emit(state.copyWith(isSaving: false, isSaved: true));
    });
  }
}
