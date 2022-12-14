part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
  final String phone;
  final String password;

  const SignInEvent({required this.phone, required this.password});
}
