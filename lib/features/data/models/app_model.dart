import 'dart:typed_data';

import '../../domain/entities/app_entity.dart';

class AppModel extends AppEntity {
  AppModel({
    int? id,
    int? bundleId,
    String? appId,
    String? title,
    String? iconUrl,
    Uint8List? iconImage,
    String? storeUrl,
  }) : super(
          id: id,
          bundleId: bundleId,
          appId: appId,
          title: title,
          iconUrl: iconUrl,
          iconImage: iconImage,
          storeUrl: storeUrl,
        );

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
        id: json['id'],
        bundleId: json['bundleId'],
        appId: json['appId'],
        title: json['title'],
        iconUrl: json['iconUrl'],
        iconImage: json['iconImage'],
        storeUrl: json['storeUrl'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'bundleId': bundleId,
        'appId': appId,
        'title': title,
        'iconUrl': iconUrl,
        'iconImage': iconImage,
        'storeUrl': storeUrl,
      };
}
