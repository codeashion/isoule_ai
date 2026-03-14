import 'package:equatable/equatable.dart';

abstract class AddMemoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MemoryTextChanged extends AddMemoryEvent {
  final String text;

  MemoryTextChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class MemoryDateTimeChanged extends AddMemoryEvent {
  final DateTime dateTime;

  MemoryDateTimeChanged(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}

class SaveMemoryRequested extends AddMemoryEvent {}
