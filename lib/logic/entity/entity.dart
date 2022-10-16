import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

typedef Value = Equatable;

class Entity<V extends Value> extends Equatable {
  final String id;
  final V o;
  @override
  List get props => [...o.props, id];
  const Entity(this.id, this.o);
}

typedef Creator<V extends Value> = Future<Either<Exception, Entity<V>>> Function(V);
typedef Reader<V extends Value> = Future<Either<Exception, Entity<V>>> Function(String id);
typedef Updater<V extends Value> = Future<Either<Exception, void>> Function(Entity<V>);
typedef Deleter<V extends Value> = Future<Either<Exception, void>> Function(String id);
