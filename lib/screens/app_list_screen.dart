import 'package:app_bundles/components/app_icon_image.dart';
import 'package:app_bundles/models/app.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          children: [
            Text(
              'Choose an app',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 10),
            FutureBuilder<List<Application>>(
              future: DeviceApps.getInstalledApplications(
                includeAppIcons: true,
                onlyAppsWithLaunchIntent: true,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: snapshot.data!.map(
                    (e) {
                      var app = App.fromApplication(e as ApplicationWithIcon);
                      return ListTile(
                        leading: AppIconImage(
                          iconImage: app.iconImage,
                          size: 40,
                        ),
                        title: Text(
                          '${app.title}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onTap: () => Navigator.of(context).pop(app),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
