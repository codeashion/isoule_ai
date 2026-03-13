import 'package:equatable/equatable.dart';
import '../models/memory_item.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDashboard extends DashboardEvent {}

class AddMemory extends DashboardEvent {
  final MemoryItem memory;

  AddMemory(this.memory);

  @override
  List<Object?> get props => [memory];
}
