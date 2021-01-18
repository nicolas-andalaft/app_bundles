import 'package:app_bundles/models/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCard extends StatelessWidget {
  final App app;
  const AppCard(this.app);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                app.iconUrl,
                height: 80,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(app.title),
              ),
            ),
            ActionChip(
              onPressed: () => launch(app.storeUrl),
              avatar: Icon(
                Icons.launch,
                color: Colors.white,
                size: 15,
              ),
              label: Text('Open'),
              backgroundColor: Theme.of(context).accentColor,
              labelStyle: TextStyle(color: Colors.white),
              labelPadding: const EdgeInsets.only(right: 5),
            ),
          ],
        ),
      ),
    );
  }
}
