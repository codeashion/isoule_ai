import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final String code;
  final bool isValid;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final bool canResend;

  const OtpState({
    this.code = '',
    this.isValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
    this.canResend = true,
  });

  OtpState copyWith({
    String? code,
    bool? isValid,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool? canResend,
  }) {
    return OtpState(
      code: code ?? this.code,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object?> get props => [
    code,
    isValid,
    isSubmitting,
    isSuccess,
    errorMessage,
    canResend,
  ];
}
