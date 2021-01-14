import 'package:app_bundles/database/bundle_dao.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:app_bundles/screens/app_form.dart';
import 'package:app_bundles/screens/bundle_screen.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    ReceiveSharingIntent.getInitialText().then(
      (value) {
        if (value != null && value.isNotEmpty) {
          if (value.contains('play.google.com') && value.contains('id=')) {
            String id = value.split('id=')[1];
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AppForm(appId: id),
              ),
            );
          }
        } else
          print('Invalid link');
      },
    );
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
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      leading: Icon(Icons.folder_open),
                      title: Text('${data[index].name}'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BundleScreen(data[index]),
                        ),
                      ).whenComplete(() => setState(() {})),
                    ),
                  );
                },
              );
            } else
              return Text('No Bundle Created');
          }
          return Container();
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
