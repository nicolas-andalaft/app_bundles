import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/bundle_repository.dart';
import '../entities/bundle_entity.dart';

class CreateBundleUsecase implements Usecase<BundleEntity, BundleEntity> {
  final IBundleRepository repository;

  CreateBundleUsecase(this.repository);

  @override
  Future<Either<Failure, BundleEntity>> call(BundleEntity bundle) async {
    final result = await repository.createBundle(bundle);
    return result is Failure ? Left(Failure()) : Right(result as BundleEntity);
  }
}
