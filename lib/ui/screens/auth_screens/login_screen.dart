// import 'package:exam_event_app/blocs/auth/auth_bloc.dart';
// import 'package:exam_event_app/blocs/auth/auth_event.dart';
// import 'package:exam_event_app/blocs/auth/auth_state.dart';
// import 'package:exam_event_app/ui/screens/home_screen.dart';
// import 'package:exam_event_app/ui/screens/register_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   // Text Controllers
//   final emailController = TextEditingController();
//   final usernameController = TextEditingController();

//   final passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email kiriting';
//     }
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Parol kiriting';
//     }
//     if (value.length < 6) {
//       return "Parol kamida 6 ta belgi bo'lishi kerak";
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Tizimga kirish',
//           style: TextStyle(
//             color: Colors.deepPurple,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               const Text('Email'),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Email kiriting',
//                 ),
//                 validator: _validateEmail,
//               ),
//               const SizedBox(height: 10),
//               const Text('Parol'),
//               TextFormField(
//                 controller: passwordController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Parol kiriting',
//                 ),
//                 obscureText: true,
//                 validator: _validatePassword,
//               ),
//               const SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {},
//                 child: const Text(
//                   'Parolni unutdingizmi?',
//                   style: TextStyle(
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 height: 50,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     context.read<AuthenticationBloc>().add(
//                           SignUpUser(
//                             email: emailController.text.trim(),
//                             username: usernameController.text.trim(),
//                             password: passwordController.text.trim(),
//                           ),
//                         );
//                   },
//                   child: const Text("Kirish"),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Hisobingiz yo'qmi? "),
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.pushNamed(context, SignupScreen.id);
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const RegisterScreen(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       "Ro'yxatdan o'tish",
//                       style: TextStyle(
//                         color: Colors.deepPurple,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_event_app/blocs/auth/auth_bloc.dart';
import 'package:exam_event_app/blocs/auth/auth_event.dart';
import 'package:exam_event_app/blocs/auth/auth_state.dart';
import 'package:exam_event_app/ui/screens/home_screen/home_screen.dart';
import 'package:exam_event_app/ui/screens/auth_screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email kiriting';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Parol kiriting";
    }
    if (value.length < 6) {
      return "Parol kamida 6 ta belgi bo'lishi kerak";
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
            LoginUserEvent(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tizimga kirish',
          style: TextStyle(color: Colors.deepPurple),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoadingState) {
            showDialog(
              context: context,
              builder: (ctx) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AuthenticationFailureState) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AuthenticationSuccessState) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text('Email'),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email kiriting',
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 10),
                  const Text('Parol'),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Parol kiriting',
                    ),
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('Kirish'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hisobingiz yo'qmi? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Ro'yxatdan o'tish",
                          style: TextStyle(
                            color: Colors.deepPurple,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
