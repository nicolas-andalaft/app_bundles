import 'package:flutter/material.dart';

import '../../domain/entities/bundle_entity.dart';

class BundleModel extends BundleEntity {
  BundleModel({
    int? id,
    String? name,
    IconData? icon,
  }) : super(
          id: id,
          name: name,
          icon: icon,
        );

  factory BundleModel.fromJson(Map<String, dynamic> json) => BundleModel();
}
