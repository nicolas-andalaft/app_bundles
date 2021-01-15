import 'package:app_bundles/components/app_card.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App List')),
      body: FutureBuilder(
        future: InstalledApps.getInstalledApps(true, true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<AppInfo> appList = snapshot.data;
              return ListView.builder(
                itemCount: appList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () =>
                        Navigator.pop(context, appList[index].packageName),
                    child: AppCard(
                      appTitle: appList[index].name,
                      appIcon: Image.memory(appList[index].icon),
                    ),
                  );
                },
              );
            } else
              return Text('Error loading installed apps');
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
