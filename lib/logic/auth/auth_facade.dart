import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UnauthenticatedException implements Exception {}

typedef AuthToken = String;

class EmailState extends Equatable {
  final String email;
  final bool isVerified;
  @override
  List get props => [email, isVerified];
  const EmailState(this.email, this.isVerified);
}

abstract class AuthFacade {
  Future<Either<Exception, void>> refresh();
  Stream<Option<AuthToken>> getTokenStream();
  Future<Option<AuthToken>> getToken();
  Future<Either<Exception, EmailState>> getEmail();
  Future<Either<Exception, void>> updateEmail(String email);
  Future<Either<Exception, void>> verifyEmail();
  Future<Either<Exception, void>> logout();
}
