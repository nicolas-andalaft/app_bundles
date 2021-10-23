import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../entities/bundle_entity.dart';

abstract class IBundleRepository {
  Future<Either<Failure, List<BundleEntity>>> getAllBundles();
  Future<Either<Failure, dynamic>> createBundle(BundleEntity bundle);
}
