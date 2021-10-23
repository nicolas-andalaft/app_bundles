import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/app_repository.dart';
import '../entities/app_entity.dart';
import '../entities/bundle_entity.dart';

class GetAppsFromBundleUsecase
    implements Usecase<BundleEntity, List<AppEntity>> {
  final IAppRepository repository;

  GetAppsFromBundleUsecase(this.repository);

  @override
  Future<Either<Failure, List<AppEntity>>> call(BundleEntity bundle) async {
    final result = await repository.getAppsFromBundle(bundle);
    return result is Failure
        ? Left(Failure())
        : Right(result as List<AppEntity>);
  }
}
