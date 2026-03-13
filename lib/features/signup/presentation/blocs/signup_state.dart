import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final String fullName;
  final String nickname;
  final DateTime? dob;
  final String email;
  final String phone;
  final String countryCode;
  final String countryFlagUri;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const SignupState({
    this.fullName = '',
    this.nickname = '',
    this.dob,
    this.email = '',
    this.phone = '',
    this.countryCode = '+1',
    this.countryFlagUri = 'flags/us.png',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  bool get isFullNameValid => fullName.trim().isNotEmpty;
  bool get isNicknameValid => nickname.trim().isNotEmpty;
  bool get isDobValid => dob != null;
  bool get isEmailValid {
    if (email.isEmpty) return false;
    return RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+").hasMatch(email);
  }

  bool get isPhoneValid {
    if (phone.isEmpty) return false;
    // Simple normalization: digits only, length >= 7
    final digits = phone.replaceAll(RegExp(r"[^0-9]"), '');
    return digits.length >= 7;
  }

  bool get isFormValid =>
      isFullNameValid &&
      isNicknameValid &&
      isDobValid &&
      isEmailValid &&
      isPhoneValid;

  SignupState copyWith({
    String? fullName,
    String? nickname,
    DateTime? dob,
    String? email,
    String? phone,
    String? countryCode,
    String? countryFlagUri,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      nickname: nickname ?? this.nickname,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryCode: countryCode ?? this.countryCode,
      countryFlagUri: countryFlagUri ?? this.countryFlagUri,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    nickname,
    dob,
    email,
    phone,
    countryCode,
    countryFlagUri,
    isSubmitting,
    isSuccess,
    errorMessage,
  ];
}
