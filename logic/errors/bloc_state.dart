import '../core.dart';

extension BlocStateExceptionGetter on BlocState {
  Exception? getException() => fold(
        () => null,
        (some) => some.fold(
          (e) => e,
          (_) => null,
        ),
      );
}
