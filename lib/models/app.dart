import 'dart:typed_data';
import 'package:device_apps/device_apps.dart';

class App {
  int? id;
  int? bundleId;
  String? appId;
  String? title;
  String? iconUrl;
  Uint8List? iconImage;
  String? storeUrl;

  App(
      {this.id,
      this.bundleId,
      this.appId,
      this.title,
      this.iconUrl,
      this.iconImage,
      this.storeUrl});

  factory App.fromApplication(ApplicationWithIcon application) => App(
        appId: application.packageName,
        iconImage: application.icon,
        title: application.appName,
      );
}
