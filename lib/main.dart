import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:exam_event_app/blocs/auth/auth_bloc.dart';
import 'package:exam_event_app/blocs/event/event_bloc.dart';
import 'package:exam_event_app/firebase_options.dart';
import 'package:exam_event_app/services/firebase/auth_service.dart';
import 'package:exam_event_app/services/firebase/event_service.dart';
import 'package:exam_event_app/ui/screens/event_screen/add_event_screen.dart';
import 'package:exam_event_app/ui/screens/event_screen/my_events_screen.dart';
import 'package:exam_event_app/ui/screens/home_screen/home_screen.dart';
import 'package:exam_event_app/ui/screens/auth_screens/login_screen.dart';
import 'package:exam_event_app/ui/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = UserAuthService();
    final eventService = EventService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(authService),
        ),
        BlocProvider(
          create: (context) => EventBloc(eventService),
        )
      ],
      child: AdaptiveTheme(
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        initial: AdaptiveThemeMode.light,
        builder: (light, dark) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            home: const MyEventsScreen(),
          );
        },
      ),
    );
  }
}
