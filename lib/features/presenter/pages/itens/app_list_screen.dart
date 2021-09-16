import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/app_entity.dart';
import '../../widgets/widgets.dart';

class AppListScreen extends StatefulWidget {
  @override
  _AppListScreenState createState() => _AppListScreenState();
}

class _AppListScreenState extends State<AppListScreen> {
  List<AppEntity>? appList;
  List<bool>? selectedApps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          children: [
            Text(
              'Select apps',
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
                appList = snapshot.data!
                    .map((e) =>
                        AppEntity.fromApplication(e as ApplicationWithIcon))
                    .toList();
                selectedApps = List.filled(appList!.length, false);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    appList!.length,
                    (index) => AppListTitle(
                      app: appList![index],
                      onChanged: (value) => selectedApps![index] = value,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConfirmBottomSheet(
        yesTitle: 'Select',
        yesFunction: () {
          List<AppEntity> result = [];
          for (int i = 0; i < appList!.length; i++)
            if (selectedApps![i]) result.add(appList![i]);

          Navigator.of(context).pop(result);
        },
        noTitle: 'Cancel',
        noFunction: () => Navigator.of(context).pop(),
      ),
    );
  }
}
