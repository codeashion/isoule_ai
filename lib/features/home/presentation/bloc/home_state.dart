import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? message;

  const HomeState({required this.status, this.message});

  factory HomeState.initial() => const HomeState(status: HomeStatus.initial);

  HomeState copyWith({HomeStatus? status, String? message}) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
