import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PageChangedEvent extends OnboardingEvent {
  final int index;

  PageChangedEvent(this.index);

  @override
  List<Object?> get props => [index];
}
