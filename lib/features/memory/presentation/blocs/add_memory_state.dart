import 'package:isoule_ai/features/home_screen/presentation/models/memory_item.dart';

class AddMemoryState {
  final String text;
  final DateTime dateTime;
  final bool isSaving;
  final String? error;
  final MemoryItem? result;

  const AddMemoryState({
    this.text = '',
    required this.dateTime,
    this.isSaving = false,
    this.error,
    this.result,
  });

  AddMemoryState copyWith({
    String? text,
    DateTime? dateTime,
    bool? isSaving,
    String? error,
    MemoryItem? result,
  }) {
    return AddMemoryState(
      text: text ?? this.text,
      dateTime: dateTime ?? this.dateTime,
      isSaving: isSaving ?? this.isSaving,
      error: error,
      result: result ?? this.result,
    );
  }
}
