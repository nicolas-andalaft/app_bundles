import 'package:dartz/dartz.dart';

import '../entities/bundle_entity.dart';
import '../../../core/errors/failure.dart';

abstract class IBundleRepository {
  Future<Either<Failure, List<BundleEntity>>> getAllBundles();
}
