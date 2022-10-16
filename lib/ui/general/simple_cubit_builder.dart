import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/core.dart';
import '../../logic/entity/entity.dart';
import '../../logic/errors/bloc_state.dart';
import '../../logic/simple_cubit.dart';
import '../errors/bloc_exception_listener.dart';
import '../errors/state_switch.dart';

typedef SimpleBuilderFactory<V extends Value> = Widget Function({
  required Future<UseCaseRes<V>> Function() load,
  required Widget Function(V, SimpleCubit<V>) loadedBuilder,
});

SimpleBuilderFactory<V> newSimpleBuilderFactory<V extends Value>(
  BlocExceptionListenerFactory<SimpleCubit<V>, BlocState<V>> exceptionListener,
) =>
    ({
      required Future<UseCaseRes<V>> Function() load,
      required Widget Function(V, SimpleCubit<V>) loadedBuilder,
    }) =>
        _SimpleCubitBuilder(
          exceptionListener: exceptionListener,
          load: load,
          loadedBuilder: loadedBuilder,
        );

class _SimpleCubitBuilder<V extends Value> extends StatelessWidget {
  final BlocExceptionListenerFactory<SimpleCubit<V>, BlocState<V>> exceptionListener;
  final Future<Either<Exception, V>> Function() load;
  final Widget Function(V, SimpleCubit<V>) loadedBuilder;
  const _SimpleCubitBuilder({
    Key? key,
    required this.exceptionListener,
    required this.load,
    required this.loadedBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SimpleCubit<V>>(
      create: (_) => SimpleCubit<V>(load),
      child: exceptionListener(
        (s) => s.getException(),
        BlocBuilder<SimpleCubit<V>, BlocState<V>>(
          builder: (context, state) => stateSwitch<V>(
            state: state,
            loadedBuilder: (v) => loadedBuilder(v, context.read<SimpleCubit<V>>()),
          ),
        ),
      ),
    );
  }
}
