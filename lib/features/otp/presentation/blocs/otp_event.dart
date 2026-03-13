import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtpCodeChanged extends OtpEvent {
  final String code;

  OtpCodeChanged(this.code);

  @override
  List<Object?> get props => [code];
}

class OtpSubmitted extends OtpEvent {}

class OtpResendRequested extends OtpEvent {}
