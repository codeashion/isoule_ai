import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(const OtpState()) {
    on<OtpCodeChanged>((event, emit) {
      final isValid = event.code.length == 4;
      emit(
        state.copyWith(code: event.code, isValid: isValid, errorMessage: null),
      );
    });

    on<OtpSubmitted>((event, emit) async {
      if (!state.isValid) {
        emit(
          state.copyWith(
            errorMessage: 'Please enter the 4-digit code.',
            isSuccess: false,
          ),
        );
        return;
      }

      emit(state.copyWith(isSubmitting: true, errorMessage: null));
      await Future.delayed(const Duration(milliseconds: 600));
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });

    on<OtpResendRequested>((event, emit) {
      emit(state.copyWith(canResend: false));
      Future.delayed(const Duration(seconds: 30), () {
        emit(state.copyWith(canResend: true));
      });
    });
  }
}
