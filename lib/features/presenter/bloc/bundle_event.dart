import '../../domain/entities/bundle_entity.dart';

abstract class BundleEvent {}

class GetAllBundlesEvent implements BundleEvent {}

class CreateBundleEvent implements BundleEvent {
  final BundleEntity data;

  CreateBundleEvent(this.data);
}
