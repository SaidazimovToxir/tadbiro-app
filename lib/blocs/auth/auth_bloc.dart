import 'package:bloc/bloc.dart';
import 'package:exam_event_app/blocs/auth/auth_event.dart';
import 'package:exam_event_app/blocs/auth/auth_state.dart';
import 'package:exam_event_app/data/models/user_model.dart';
import 'package:exam_event_app/services/firebase/auth_service.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserAuthService authService;

  AuthenticationBloc(this.authService) : super(AuthenticationInitialState()) {
    on<LoginUserEvent>(_logInUser);
    on<RegisterUserEvent>(_registerUser);
    on<SignOutEvent>(_signOutUser);
  }

  void _logInUser(
    LoginUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    try {
      final user = await authService.logInUser(event.email, event.password);
      if (user != null) {
        emit(AuthenticationSuccessState(user));
      } else {
        emit(AuthenticationFailureState('Login failed'));
      }
    } catch (e) {
      emit(AuthenticationFailureState(e.toString()));
    }
  }

  void _registerUser(
    RegisterUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    try {
      final user = await authService.registerUser(
          event.email, event.password, event.username);
      if (user != null) {
        emit(AuthenticationSuccessState(user));
      } else {
        emit(AuthenticationFailureState('Registration failed'));
      }
    } catch (e) {
      emit(AuthenticationFailureState(e.toString()));
    }
  }

  void _signOutUser(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    try {
      await authService.signOut();
      emit(AuthenticationInitialState());
    } catch (e) {
      emit(AuthenticationFailureState(e.toString()));
    }
  }
}
