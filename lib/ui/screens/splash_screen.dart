import 'package:exam_event_app/ui/screens/home_screen/home_screen.dart';
import 'package:exam_event_app/ui/screens/auth_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  void _loadNextPage() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              // return StreamBuilder(
              //   stream: FirebaseAuth.instance.authStateChanges(),
              //   builder: (context, AsyncSnapshot<User?> userSnapshot) {
              //     print(userSnapshot);
              //     if (userSnapshot.hasData) {
              //       return const HomeScreen();
              //     } else {
              //       return const LoginScreen();
              //     }
              //   },
              // );
              return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const HomeScreen();
                  } else {
                    return const LoginScreen();
                  }
                },
              );
            },
            // const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.bounceIn;
              dynamic tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              dynamic offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 350,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  "https://w7.pngwing.com/pngs/23/900/png-transparent-event-management-computer-icons-business-engagement-marketing-event-blue-text-service-thumbnail.png",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
