import 'package:dartz/dartz.dart';

import '../models/bundle_model.dart';

abstract class IBundleDatasource {
  Future<Either<Exception, List<BundleModel>>> getAllBundles();
  Future<Either<Exception, List<BundleModel>>> createBundle(BundleModel bundle);
}
