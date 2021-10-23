import 'package:app_bundles/features/domain/entities/bundle_entity.dart';

abstract class BundleState {}

class Empty implements BundleState {}

class Loading implements BundleState {}

class Loaded implements BundleState {
  final List<BundleEntity> bundles;

  Loaded(this.bundles);
}

class Error implements BundleState {
  final String message;

  Error(this.message);
}
