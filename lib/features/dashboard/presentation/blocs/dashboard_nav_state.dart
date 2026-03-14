import 'package:equatable/equatable.dart';

class DashboardNavState extends Equatable {
  final int selectedIndex;

  const DashboardNavState({this.selectedIndex = 0});

  DashboardNavState copyWith({int? selectedIndex}) {
    return DashboardNavState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}
