import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth/auth_facade.dart';
import '../../logic/errors/errors.dart';
import 'exception_snackbar.dart';

typedef BlocExceptionListenerFactory = Widget Function<B extends BlocBase<S>, S>(
  Exception? Function(S) getException,
  Widget child,
);

BlocExceptionListenerFactory newBlocExceptionListenerFactory(
  AuthFacade auth,
) =>
    <B extends BlocBase<S>, S>(getException, child) => _BlocExceptionListener<B, S>(
          auth: auth,
          getException: getException,
          child: child,
        );

class _BlocExceptionListener<B extends BlocBase<S>, S> extends StatelessWidget {
  final AuthFacade auth;
  final Exception? Function(S) getException;
  final Widget child;
  const _BlocExceptionListener({
    Key? key,
    required this.auth,
    required this.getException,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (context, state) {
        final e = getException(state);
        if (e != null) {
          if (e is NetworkException && e.statusCode == 401) {
            auth.refresh();
          } else {
            showExceptionSnackbar(context, e);
          }
        }
      },
      child: child,
    );
  }
}
