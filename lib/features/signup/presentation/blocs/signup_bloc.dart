import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<FullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName, errorMessage: null));
    });

    on<NicknameChanged>((event, emit) {
      emit(state.copyWith(nickname: event.nickname, errorMessage: null));
    });

    on<DobChanged>((event, emit) {
      emit(state.copyWith(dob: event.dob, errorMessage: null));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, errorMessage: null));
    });

    on<CountryChanged>((event, emit) {
      emit(state.copyWith(countryCode: event.countryCode, errorMessage: null));
    });

    on<PhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone, errorMessage: null));
    });

    on<ProfileImageChanged>((event, emit) {
      emit(
        state.copyWith(profileImagePath: event.imagePath, errorMessage: null),
      );
    });

    on<SignupSubmitted>((event, emit) async {
      if (!state.isFormValid) {
        emit(
          state.copyWith(
            errorMessage: 'Please fill out all fields correctly.',
            isSuccess: false,
          ),
        );
        return;
      }

      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      // Simulate a network call / profile setup
      await Future.delayed(const Duration(milliseconds: 700));

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
