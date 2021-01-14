import 'package:flutter/material.dart';
import 'package:app_bundles/models/app.dart';
import 'package:google_play_store_scraper_dart/google_play_store_scraper_dart.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCard extends StatefulWidget {
  final App app;
  const AppCard(this.app);

  @override
  _AppCardState createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  GooglePlayScraperDart scrapper = GooglePlayScraperDart();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: scrapper.app(appID: widget.app.appId, gl: 'us'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data;
                return ListTile(
                  leading: Image.network('${data["icon"]}'),
                  title: Text('${data["title"]}'),
                  subtitle: Row(
                    children: [
                      Chip(
                        label: Text(data['price'] == '0'
                            ? 'Free'
                            : r'U$ ' + data['price']),
                      )
                    ],
                  ),
                  trailing: ActionChip(
                    onPressed: () => launch(data['url']),
                    avatar: Icon(
                      Icons.launch,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text('Open'),
                    backgroundColor: Theme.of(context).accentColor,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                );
              } else
                return Text('no data found');
            } else
              return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
