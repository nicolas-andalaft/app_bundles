import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/bundle_repository.dart';
import '../entities/bundle_entity.dart';

class GetAllBundlesUsecase implements Usecase<NoParams, List<BundleEntity>> {
  final IBundleRepository repository;

  GetAllBundlesUsecase(this.repository);

  @override
  Future<Either<Failure, List<BundleEntity>>> call(NoParams params) async {
    final result = await repository.getAllBundles();
    return result is Failure
        ? Left(Failure())
        : Right(result as List<BundleEntity>);
  }
}
