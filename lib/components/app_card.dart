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
  final GooglePlayScraperDart scrapper = GooglePlayScraperDart();
  String _appTitle;
  String _appPrice;
  String _appIcon;
  String _appUrl;

  void _getAppData() {
    scrapper.app(appID: widget.app.appId, gl: 'us').then((data) => setState(() {
          _appTitle = data['title'];
          _appPrice = data['price'];
          _appIcon = data['icon'];
          _appUrl = data['url'];
        }));
  }

  @override
  void initState() {
    _getAppData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: _appTitle == null
          ? Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network('$_appIcon'),
                  ),
                ),
                title: Text(_appTitle),
                subtitle: Row(
                  children: [
                    Chip(
                      label: Text(_appPrice == '0' ? 'Free' : 'US $_appPrice'),
                    ),
                    SizedBox(width: 10),
                    ActionChip(
                      onPressed: () => launch(_appUrl),
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
            ),
    );
  }
}
