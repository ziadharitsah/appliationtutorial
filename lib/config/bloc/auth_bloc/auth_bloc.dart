import 'dart:async';

import 'package:appliationtutorial/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await repository.hasToken();
      if (hasToken) {
        emit(AuthAuthenticate());
      } else {
        emit(AuthUnAuthenticate());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      await repository.persisToken(event.token);
      emit(AuthAuthenticate());
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await repository.deleteToken();
      emit(AuthUnAuthenticate());
    });
  }
}
