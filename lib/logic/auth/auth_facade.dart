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

class AuthFacadeImpl implements AuthFacade {
  @override
  Future<Either<Exception, EmailState>> getEmail() {
    // TODO: implement getEmail
    throw UnimplementedError();
  }

  @override
  Future<Option<AuthToken>> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Stream<Option<AuthToken>> getTokenStream() {
    // TODO: implement getTokenStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, void>> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, void>> updateEmail(String email) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, void>> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
