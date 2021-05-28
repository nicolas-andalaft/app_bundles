import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppIconImage extends StatelessWidget {
  final Uint8List? iconImage;
  final String? iconUrl;
  final double? size;
  AppIconImage({this.iconImage, this.iconUrl, this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(360),
      child: Container(
        height: size ?? double.infinity,
        width: size ?? double.infinity,
        color: Colors.black26,
        child: AspectRatio(
          aspectRatio: 1,
          child: iconImage != null
              ? Image.memory(iconImage!)
              : iconUrl != null && iconUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: iconUrl!,
                    )
                  : SizedBox(),
        ),
      ),
    );
  }
}
