import 'package:equatable/equatable.dart';

abstract class DashboardNavEvent extends Equatable {
  const DashboardNavEvent();

  @override
  List<Object?> get props => [];
}

class DashboardTabSelected extends DashboardNavEvent {
  final int index;

  const DashboardTabSelected(this.index);

  @override
  List<Object?> get props => [index];
}
