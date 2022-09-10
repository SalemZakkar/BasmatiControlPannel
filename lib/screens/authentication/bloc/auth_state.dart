part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthInitial {}

class AuthError extends AuthState {
  @override
  List<Object?> get props => [];
  final String code;

  const AuthError({required this.code});
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthReset extends AuthState {
  @override
  List<Object?> get props => [];
}
