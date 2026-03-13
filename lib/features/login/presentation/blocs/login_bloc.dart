import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

bool _isValidEmail(String email) {
  if (email.isEmpty) return false;
  // Simple email validation
  return RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+").hasMatch(email);
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      emit(
        state.copyWith(
          email: event.email,
          isEmailValid: _isValidEmail(event.email),
          errorMessage: null,
          isSuccess: false,
        ),
      );
    });

    on<ContinuePressed>((event, emit) async {
      if (!state.isEmailValid) {
        emit(
          state.copyWith(
            errorMessage: 'Please enter a valid email address.',
            isSuccess: false,
          ),
        );
        return;
      }

      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      // Simulate network/auth request.
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
