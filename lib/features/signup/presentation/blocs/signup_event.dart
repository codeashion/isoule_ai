import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FullNameChanged extends SignupEvent {
  final String fullName;

  FullNameChanged(this.fullName);

  @override
  List<Object?> get props => [fullName];
}

class NicknameChanged extends SignupEvent {
  final String nickname;

  NicknameChanged(this.nickname);

  @override
  List<Object?> get props => [nickname];
}

class DobChanged extends SignupEvent {
  final DateTime dob;

  DobChanged(this.dob);

  @override
  List<Object?> get props => [dob];
}

class EmailChanged extends SignupEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class CountryChanged extends SignupEvent {
  final String countryCode;

  CountryChanged({required this.countryCode});

  @override
  List<Object?> get props => [
    countryCode,
    // countryFlag,
  ];
}

class PhoneChanged extends SignupEvent {
  final String phone;

  PhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class ProfileImageChanged extends SignupEvent {
  final String imagePath;

  ProfileImageChanged(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class SignupSubmitted extends SignupEvent {}
