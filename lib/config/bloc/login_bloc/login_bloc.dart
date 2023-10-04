import 'dart:async';

import 'package:appliationtutorial/config/bloc/auth_bloc/auth_bloc.dart';
import 'package:appliationtutorial/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;
  final AuthBloc authBloc;
  LoginBloc({required this.repository, required this.authBloc})
      : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final token = await repository.login(event.email, event.password);
        authBloc.add(LoggedIn(token: token));
        emit(LoginInitial());
      } catch (errors) {
        emit(LoginFailure(error: errors.toString()));
      }
    });
  }
}
