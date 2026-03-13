import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final bool isEmailValid;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.isEmailValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    bool? isEmailValid,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    isEmailValid,
    isSubmitting,
    isSuccess,
    errorMessage,
  ];
}
