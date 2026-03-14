import 'package:equatable/equatable.dart';

class ReflectionState extends Equatable {
  final int selectedMood;
  final String reflectionText;
  final bool isSaving;
  final bool isSaved;

  const ReflectionState({
    this.selectedMood = 2,
    this.reflectionText = '',
    this.isSaving = false,
    this.isSaved = false,
  });

  ReflectionState copyWith({
    int? selectedMood,
    String? reflectionText,
    bool? isSaving,
    bool? isSaved,
  }) {
    return ReflectionState(
      selectedMood: selectedMood ?? this.selectedMood,
      reflectionText: reflectionText ?? this.reflectionText,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [selectedMood, reflectionText, isSaving, isSaved];
}
