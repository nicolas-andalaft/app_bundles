import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/app_repository.dart';
import '../entities/app_entity.dart';

class CreateAppUsecase implements Usecase<AppEntity, AppEntity> {
  final IAppRepository repository;

  CreateAppUsecase(this.repository);

  @override
  Future<Either<Failure, AppEntity>> call(AppEntity app) async {
    final result = await repository.createApp(app);
    return result is Failure ? Left(Failure()) : Right(result as AppEntity);
  }
}
