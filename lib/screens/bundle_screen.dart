import 'package:flutter/material.dart';
import 'package:app_bundles/components/app_card.dart';
import 'package:app_bundles/database/app_dao.dart';
import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/bundle.dart';

class BundleScreen extends StatefulWidget {
  final Bundle bundle;
  BundleScreen(this.bundle);

  @override
  _BundleScreenState createState() => _BundleScreenState();
}

class _BundleScreenState extends State<BundleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.bundle.name}')),
      body: FutureBuilder<List<App>>(
        future: AppDao.readFromBundle(widget.bundle),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) => AppCard(snapshot.data[index]),
            );
          return LinearProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .pushNamed('/appform')
            .then((data) => data != null ? setState(() {}) : null),
      ),
    );
  }
}
