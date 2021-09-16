import 'dart:typed_data';
import 'package:device_apps/device_apps.dart';

class AppEntity {
  int? id;
  int? bundleId;
  String? appId;
  String? title;
  String? iconUrl;
  Uint8List? iconImage;
  String? storeUrl;

  AppEntity({
    this.id,
    this.bundleId,
    this.appId,
    this.title,
    this.iconUrl,
    this.iconImage,
    this.storeUrl,
  });

  factory AppEntity.fromApplication(ApplicationWithIcon application) =>
      AppEntity(
        appId: application.packageName,
        iconImage: application.icon,
        title: application.appName,
      );
}
