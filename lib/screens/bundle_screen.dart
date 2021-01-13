import 'package:app_bundles/database/app_dao.dart';
import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:flutter/material.dart';

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
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<App> data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    leading: Icon(Icons.android),
                    title: Text('${data[index].appLink}'),
                  ),
                ),
              );
            } else
              return Text('No Apps Saved');
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
