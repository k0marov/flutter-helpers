import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../entity/entity.dart';

enum UpdateState {
  unchanged,
  editing,
  updating,
  updated,
}

class FormCubitState<V> extends Equatable {
  final V? initial;
  final V? val;
  final UpdateState upd;
  final Exception? exception;
  @override
  List get props => [initial, val, upd, exception];

  bool get isEditing => upd != UpdateState.unchanged;

  const FormCubitState([this.initial, this.val, this.upd = UpdateState.unchanged, this.exception]);

  bool updateAvailable() => initial != val && val != null;
  FormCubitState<V> withValue(V? val) => FormCubitState<V>(initial, val, upd, exception);
  FormCubitState<V> withUpdState(UpdateState upd) =>
      FormCubitState<V>(initial, val, upd, exception);
  FormCubitState<V> withException(Exception? e) => FormCubitState<V>(initial, val, upd, e);
}

class FormCubit<V extends Value> extends Cubit<FormCubitState<V>> {
  final Reader<V> _read;
  final Updater<V> _upd;
  final String _id;
  FormCubit(
    this._read,
    this._upd,
    this._id,
  ) : super(const FormCubitState()) {
    _fetchAndEmit();
  }

  void editPressed() {
    emit(state.withUpdState(UpdateState.editing));
  }

  void cancelPressed() {
    emit(state.withUpdState(UpdateState.unchanged).withValue(state.initial));
  }

  void valueEdited(V newValue) {
    emit(state.withValue(newValue));
  }

  void updatePressed() {
    final currentVal = state.val;
    if (currentVal != null) {
      _updateAndEmit(currentVal);
    }
  }

  void _fetchAndEmit() {
    _read(_id).then(
      (res) => res.fold(
        (e) => emit(state.withException(e)),
        (newV) => emit(FormCubitState(newV.o, newV.o)),
      ),
    );
  }

  void _updateAndEmit(V newV) {
    emit(state.withUpdState(UpdateState.updating));
    _upd(Entity<V>(_id, newV)).then(
      (res) => res.fold(
        (e) => emit(state.withUpdState(UpdateState.editing).withException(e)),
        (success) => emit(FormCubitState(newV, newV, UpdateState.updated)),
      ),
    );
  }
}
