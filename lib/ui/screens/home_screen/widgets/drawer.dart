import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_event_app/blocs/auth/auth_bloc.dart';
import 'package:exam_event_app/blocs/auth/auth_event.dart';
import 'package:exam_event_app/services/firebase/auth_service.dart';
import 'package:exam_event_app/ui/screens/event_screen/my_events_screen.dart';
import 'package:exam_event_app/ui/screens/profile_screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _authService = UserAuthService();
  final _currentUser = FirebaseAuth.instance.currentUser;
  String username = '';
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    if (_currentUser != null) {
      DocumentSnapshot user = await _authService.getUserInfo(_currentUser.uid);
      setState(() {
        username = user['userName'] ?? '';
        photoUrl = user['photoUrl'] ??
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWwfGUCDwrZZK12xVpCOqngxSpn0BDpq6ewQ&s";
      });
    }
  }

  bool _toggleIsDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: const Text(""),
            currentAccountPicture: CircleAvatar(
              child: Image.network(
                photoUrl ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWwfGUCDwrZZK12xVpCOqngxSpn0BDpq6ewQ&s",
                errorBuilder: (context, error, stackTrace) {
                  return const Text("Rasm");
                },
              ),
            ),
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(CupertinoIcons.tickets),
            title: const Text('Mening tadbirlarim'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyEventsScreen(),
                ),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(Icons.person_2_outlined),
            title: const Text("Profil Ma'lumotlari"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(Icons.translate),
            title: const Text("Tillarni o'zgartirish"),
            onTap: () {},
          ),
          SwitchListTile(
            title: const Text("Tungi holat"),
            value: _toggleIsDarkMode,
            onChanged: (value) {
              AdaptiveTheme.of(context).toggleThemeMode();
              setState(() {
                _toggleIsDarkMode = !_toggleIsDarkMode;
              });
            },
          ),
          ListTile(
            trailing: const Icon(Icons.logout),
            title: const Text("Log out "),
            onTap: () {
              context.read<AuthenticationBloc>().add((SignOutEvent()));
            },
          ),
        ],
      ),
    );
  }
}
