import 'package:equatable/equatable.dart';
import '../models/memory_item.dart';

class DashboardState extends Equatable {
  final List<MemoryItem> memories;

  const DashboardState({this.memories = const []});

  DashboardState copyWith({List<MemoryItem>? memories}) {
    return DashboardState(memories: memories ?? this.memories);
  }

  @override
  List<Object?> get props => [memories];
}
