import 'package:app_bundles/components/app_icon_image.dart';
import 'package:app_bundles/models/app.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final App? app;
  final Function()? onTap;
  final double? iconSize;
  final double? labelSize;
  const AppCard({
    this.app,
    this.onTap,
    this.iconSize,
    this.labelSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(360),
            child: AppIconImage(
              iconImage: app?.iconImage,
              iconUrl: app?.iconUrl,
            ),
          ),
          iconSize: iconSize ?? 20,
          onPressed: onTap,
        ),
        SizedBox(height: 10),
        SizedBox(
          width: labelSize,
          child: Text(
            app?.title ?? 'No app',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
