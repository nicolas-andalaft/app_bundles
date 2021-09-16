import 'package:app_bundles/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class Usecase<Params, Output> {
  Future<Either<Failure, Output>> call(Params params);
}

class NoParams {}
