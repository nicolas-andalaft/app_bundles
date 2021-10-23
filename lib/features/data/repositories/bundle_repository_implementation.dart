import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../domain/entities/bundle_entity.dart';
import '../../domain/repositories/bundle_repository.dart';
import '../models/bundle_model.dart';
import '../datasources/bundle_datasource.dart';

class BundleRepositoryImplementation implements IBundleRepository {
  final IBundleDatasource datasource;

  BundleRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, List<BundleModel>>> getAllBundles() async {
    final result = await datasource.getAllBundles();
    return result is Exception
        ? Left(Failure())
        : Right(result as List<BundleModel>);
  }

  @override
  Future<Either<Failure, List<BundleModel>>> createBundle(
      BundleEntity bundle) async {
    final model = BundleModel(
      id: bundle.id,
      name: bundle.name,
      icon: bundle.icon,
    );

    final result = await datasource.createBundle(model);
    return result is Exception ? Left(Failure()) : Right(result as dynamic);
  }
}
