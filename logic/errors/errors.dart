import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../general.dart';

Future<Either<Exception, T>> withExceptionHandling<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } catch (e) {
    printDebug("caught exception: $e");
    return Left(e is Exception ? e : Exception(e));
  }
}

String displayException(Exception e) {
  // TODO: add more error messages
  return "Ooops. Some error happened.";
}

class NetworkException extends Equatable implements Exception {
  final int statusCode;
  final String body;

  @override
  List get props => [statusCode, body];

  const NetworkException(this.statusCode, this.body);
}
