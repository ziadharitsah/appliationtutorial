part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() {
    // TODO: implement toString
    return 'LoginFailure {error: $error}';
  }
}
