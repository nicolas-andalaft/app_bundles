import 'package:app_bundles/components/app_card.dart';
import 'package:app_bundles/database/app_dao.dart';
import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:flutter/material.dart';
import 'package:google_play_store_scraper_dart/google_play_store_scraper_dart.dart';

class BundleScreen extends StatefulWidget {
  final Bundle bundle;

  const BundleScreen(this.bundle);

  @override
  _BundleScreenState createState() => _BundleScreenState();
}

class _BundleScreenState extends State<BundleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.bundle.name}')),
      body: FutureBuilder(
        future: AppDao.readFromBundle(widget.bundle),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<App> data = snapshot.data;
              GooglePlayScraperDart scrapper = GooglePlayScraperDart();

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => FutureBuilder(
                  future: scrapper.app(appID: data[index].appId, gl: 'us'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData)
                        return AppCard(
                          appTitle: snapshot.data['title'],
                          appIcon: Image.network(snapshot.data['icon']),
                          appPrice: snapshot.data['price'],
                          appUrl: snapshot.data['url'],
                        );
                      else
                        return Text('Error loading app data');
                    } else
                      return CircularProgressIndicator();
                  },
                ),
              );
            } else
              return Text('No Apps Saved');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .pushNamed('/appform')
            .whenComplete(() => setState(() {})),
      ),
    );
  }
}
