import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../entities/app_entity.dart';
import '../entities/bundle_entity.dart';

abstract class IAppRepository {
  Future<Either<Failure, List<AppEntity>>> getAppsFromBundle(
      BundleEntity bundle);
  Future<Either<Failure, dynamic>> createApp(AppEntity app);
}
