// import 'package:bloc/bloc.dart';
// import 'package:exam_event_app/blocs/auth/auth_event.dart';
// import 'package:exam_event_app/blocs/auth/auth_state.dart';
// import 'package:exam_event_app/data/models/user_model.dart';
// import 'package:exam_event_app/services/auth_service.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final AuthService authService = AuthService();

//   AuthenticationBloc() : super(AuthenticationInitialState()) {
//     on<AuthenticationEvent>((event, emit) {});

//     on<SignUpUser>(_signUpUser);
//     on<RegiterUserEvent>(_registerUser);
//     on<SignOut>(_signOutUser);
//   }
//   void _signUpUser(event, emit) async {
//     emit(AuthenticationLoadingState());
//     try {
//       final UserModel? user =
//           await authService.signUpUser(event.email, event.password);
//       if (user != null) {
//         emit(AuthenticationSuccessState(user));
//       } else {
//         emit(const AuthenticationFailureState('create user failed'));
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//     emit(AuthenticationLoadingState());
//   }

//   void _registerUser(event, emit) async {
//     emit(AuthenticationLoadingState());
//     try {
//       if (condition) {

//       } else {

//       }
//     } catch (e) {
//       print("Register error:$e");
//     }
//   }

//   void _signOutUser(event, emit) async {
//     emit(AuthenticationLoadingState());
//     try {
//       authService.signOutUser();
//     } catch (e) {
//       print('error');
//       print(e.toString());
//     }
//     emit(AuthenticationLoadingState());
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:exam_event_app/blocs/auth/auth_event.dart';
// import 'package:exam_event_app/blocs/auth/auth_state.dart';
// import 'package:exam_event_app/data/models/user_model.dart';
// import 'package:exam_event_app/services/auth_service.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final UserAuthService authService = UserAuthService();

//   AuthenticationBloc() : super(AuthenticationInitialState()) {
//     on<AuthenticationEvent>((event, emit) {});

//     on<LoginUserEvent>(_signUpUser);
//     on<RegisterUserEvent>(_registerUser);
//     on<SignOut>(_signOutUser);
//   }

//   void _signUpUser(
//       LoginUserEvent event, Emitter<AuthenticationState> emit) async {
//     emit(AuthenticationLoadingState());
//     try {
//       // final  user = await authService.logInUser(
//       //     event.email, event.password);
//      final user = authService.logInUser(event.email, event.password);
//       if (user != null) {
//         emit(AuthenticationSuccessState(user));
//       } else {
//         emit(const AuthenticationFailureState('Create user failed'));
//       }
//     } catch (e) {
//       emit(AuthenticationFailureState(e.toString()));
//     }
//   }

//   void _registerUser(
//       RegisterUserEvent event, Emitter<AuthenticationState> emit) async {
//     emit(AuthenticationLoadingState());
//     try {
//       final UserModel? user = await authService.registerUser(
//           event.email, event.password, event.username);
//       if (user != null) {
//         emit(AuthenticationSuccessState(user));
//       } else {
//         emit(const AuthenticationFailureState('Registration failed'));
//       }
//     } catch (e) {
//       emit(AuthenticationFailureState(e.toString()));
//     }
//   }

//   void _signOutUser(SignOut event, Emitter<AuthenticationState> emit) async {
//     emit(AuthenticationLoadingState());
//     try {
//       await authService.signOutUser();
//       emit(AuthenticationInitialState());
//     } catch (e) {
//       emit(AuthenticationFailureState(e.toString()));
//     }
//   }
// }

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
