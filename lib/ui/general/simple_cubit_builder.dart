import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpers/logic/errors/bloc_state.dart';

import '../../logic/core.dart';
import '../../logic/entity/entity.dart';
import '../../logic/simple_cubit.dart';
import '../errors/bloc_exception_listener.dart';
import '../errors/state_switch.dart';

typedef SimpleBuilderFactory = Widget Function<V extends Value>({
  required Future<UseCaseRes<V>> Function() load,
  required Widget Function(V, SimpleCubit<V>) loadedBuilder,
});

SimpleBuilderFactory newSimpleBuilderFactory<V extends Value>(
  BlocExceptionListenerFactory exceptionListener,
) =>
    <V extends Value>({
      required Future<UseCaseRes<V>> Function() load,
      required Widget Function(V, SimpleCubit<V>) loadedBuilder,
    }) =>
        _SimpleCubitBuilder(
          exceptionListener: exceptionListener,
          load: load,
          loadedBuilder: loadedBuilder,
        );

class _SimpleCubitBuilder<V extends Value> extends StatelessWidget {
  final BlocExceptionListenerFactory exceptionListener;
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
      child: exceptionListener<SimpleCubit<V>, BlocState<V>>(
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
