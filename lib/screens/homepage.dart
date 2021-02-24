import 'package:app_bundles/components/bundle_card.dart';
import 'package:app_bundles/database/bundle_dao.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:app_bundles/models/route_names.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void _checkSharedLink() async {
    String link = await ReceiveSharingIntent.getInitialText();

    // Check if string exists
    if (link != null && link.isNotEmpty) {
      if (link.contains('play.google.com') && link.contains('id=')) {
        // Valid link
        String id = link.split('id=')[1];
        Navigator.of(context).pushNamed(RouteNames.appForm, arguments: id);
      } else
        // Invalid link
        Fluttertoast.showToast(msg: 'Invalid App Link');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkSharedLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Bundles')),
      body: FutureBuilder(
        future: BundleDao.readAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active)
            return Center(
              child: CircularProgressIndicator(),
            );

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Bundle> data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return BundleCard(data[index]);
                },
              );
            } else
              return Center(child: Text('No Bundle Created'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .pushNamed(RouteNames.appForm)
            .whenComplete(() => setState(() {})),
      ),
    );
  }
}
