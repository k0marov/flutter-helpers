import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../logic/auth/auth_facade.dart';
import 'home_screen.dart';
import 'splash_screen.dart';

class AuthGate extends StatelessWidget {
  final Widget Function(BuildContext) authScreen;
  final AuthFacade auth;

  const AuthGate({
    Key? key,
    required this.auth,
    required this.authScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Option<AuthToken>>(
      stream: auth.getTokenStream(),
      builder: (context, snapshot) => snapshot.hasData
          ? snapshot.data!.fold(
              () => authScreen(context),
              (_) => const HomeScreen(),
            )
          : const SplashScreen(),
    );
  }
}
