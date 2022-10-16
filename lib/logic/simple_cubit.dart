import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'core.dart';

class SimpleCubit<V extends Equatable> extends Cubit<BlocState<V>> {
  final Future<Either<Exception, V>> Function() _load;
  SimpleCubit(this._load) : super(const None()) {
    refresh();
  }

  void refresh() {
    _load().then(
      (result) => result.fold(
        (exception) => emit(Some(Left(exception))),
        (success) => emit(Some(Right(success))),
      ),
    );
  }
}
