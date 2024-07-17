// import 'package:exam_event_app/data/models/user_model.dart';
// // part of 'authentication_bloc.dart';

// abstract class AuthenticationState {
//   const AuthenticationState();

//   List<Object> get props => [];
// }

// class AuthenticationInitialState extends AuthenticationState {}

// class AuthenticationLoadingState extends AuthenticationState {}

// class AuthenticationSuccessState extends AuthenticationState {
//   final UserModel user;

//   const AuthenticationSuccessState(this.user);
//   @override
//   List<Object> get props => [user];
// }

// class AuAuthenticationNotSuccessState extends AuthenticationState {}

// class AuthenticationFailureState extends AuthenticationState {
//   final String errorMessage;

//   const AuthenticationFailureState(this.errorMessage);

//   @override
//   List<Object> get props => [errorMessage];
// }

// import 'package:exam_event_app/data/models/user_model.dart';

// abstract class AuthenticationState {

// }

// class AuthenticationInitialState extends AuthenticationState {}

// class AuthenticationLoadingState extends AuthenticationState {}

// class AuthenticationSuccessState extends AuthenticationState {
//   final UserModel user;

//   AuthenticationSuccessState(this.user);
// }

// class AuthenticationFailureState extends AuthenticationState {
//   final String error;

//   AuthenticationFailureState(this.error);

// }

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
