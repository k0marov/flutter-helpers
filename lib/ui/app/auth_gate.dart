import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../logic/auth/auth_facade.dart';

class AuthGate extends StatelessWidget {
  final Widget authScreen;
  final Widget splashScreen;
  final Widget homeScreen;
  final AuthFacade auth;

  const AuthGate({
    Key? key,
    required this.auth,
    required this.homeScreen, 
    required this.authScreen,
    required this.splashScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Option<AuthToken>>(
      stream: auth.getTokenStream(),
      builder: (context, snapshot) => snapshot.hasData
          ? snapshot.data!.fold(
              () => authScreen,
              (_) => homeScreen,
            )
          : splashScreen,
    );
  }
}
