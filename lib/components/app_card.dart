import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCard extends StatelessWidget {
  final String appTitle;
  final Image appIcon;
  final String appPrice;
  final String appUrl;
  const AppCard({this.appTitle, this.appIcon, this.appPrice, this.appUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListTile(
          leading: SizedBox(
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: appIcon,
            ),
          ),
          title: Text(appTitle),
          subtitle: Row(
            children: [
              appPrice != null
                  ? Chip(
                      label: Text(appPrice == '0' ? 'Free' : 'US $appPrice'),
                    )
                  : Container(),
              SizedBox(width: 10),
              appUrl != null
                  ? ActionChip(
                      onPressed: () => launch(appUrl),
                      avatar: Icon(
                        Icons.launch,
                        color: Colors.white,
                        size: 15,
                      ),
                      label: Text('Open'),
                      backgroundColor: Theme.of(context).accentColor,
                      labelStyle: TextStyle(color: Colors.white),
                      labelPadding: const EdgeInsets.only(right: 5),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
