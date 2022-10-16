import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'entity/entity.dart';

typedef BlocState<S extends Equatable> = Option<Either<Exception, S>>;

typedef UseCaseRes<V extends Value> = Either<Exception, V>;
