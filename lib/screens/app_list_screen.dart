import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App List')),
      body: FutureBuilder<List<AppInfo>>(
        future: InstalledApps.getInstalledApps(true, true),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return InkWell(
                      onTap: () =>
                          Navigator.pop(_, snapshot.data[index].packageName),
                      child: ListTile(
                        leading: Image.memory(snapshot.data[index].icon),
                        title: Text(snapshot.data[index].name),
                      ));
                },
              );
            } else
              return Text('Error loading installed apps');
          } else
            return LinearProgressIndicator();
        },
      ),
    );
  }
}
