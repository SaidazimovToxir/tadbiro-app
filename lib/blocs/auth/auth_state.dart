import 'package:exam_event_app/data/models/user_model.dart';

abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {
  final UserModel user;

  AuthenticationSuccessState(this.user);
}

class AuthenticationFailureState extends AuthenticationState {
  final String error;

  AuthenticationFailureState(this.error);
}
