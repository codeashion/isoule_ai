abstract class ReflectionEvent {
  const ReflectionEvent();
}

class ReflectionMoodSelected extends ReflectionEvent {
  const ReflectionMoodSelected(this.moodIndex);

  final int moodIndex;
}

class ReflectionTextChanged extends ReflectionEvent {
  const ReflectionTextChanged(this.text);

  final String text;
}

class ReflectionSaveRequested extends ReflectionEvent {
  const ReflectionSaveRequested();
}
