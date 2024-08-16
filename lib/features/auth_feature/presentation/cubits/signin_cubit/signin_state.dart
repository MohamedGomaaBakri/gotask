part of 'signin_cubit.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}


class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {
  final UserEntity userEntity;
  SigninSuccess(this.userEntity);
}

class SigninError extends SigninState {
  final String message;
  SigninError(this.message);
}