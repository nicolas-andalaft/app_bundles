import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch_store/flutter_launch_store.dart';

import '../../domain/entities/app_entity.dart';

showAppBottomSheet(BuildContext context, AppEntity app) async {
  bool isInstalled = await DeviceApps.isAppInstalled(app.appId!);

  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${app.title}',
          ),
          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 3,
            children: [
              OutlinedButton.icon(
                icon: Icon(Icons.launch),
                label: Text('Open'),
                onPressed:
                    isInstalled ? () => DeviceApps.openApp(app.appId!) : null,
              ),
              OutlinedButton.icon(
                icon: Icon(Icons.local_mall_outlined),
                label: Text('Playstore'),
                onPressed: () => StoreLauncher.openWithStore(app.appId!)
                    .catchError((e) => print(e)),
              ),
              OutlinedButton.icon(
                icon: Icon(Icons.star_border),
                label: Text('Star'),
                onPressed: () {},
              ),
              OutlinedButton.icon(
                icon: Icon(Icons.edit_outlined),
                label: Text('Edit'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
