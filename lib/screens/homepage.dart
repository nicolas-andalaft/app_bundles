import 'package:app_bundles/components/bundle_card.dart';
import 'package:app_bundles/database/bundle_dao.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:app_bundles/models/route_names.dart';
import 'package:app_bundles/utils/shared_intent.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Bundle>? bundles;
  bool sharedDataChecked = false;

  void _initialize(BuildContext context) async {
    // Check for share intent
    if (!sharedDataChecked && SharedIntent.hasData) {
      sharedDataChecked = true;
      Navigator.of(context).pushNamed(
        RouteNames.appForm,
        arguments: SharedIntent.data,
      );
    } else
      _getBundles();
  }

  void _getBundles() {
    BundleDao.readAll().then((value) => setState(() => bundles = value));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) => _initialize(context));
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          children: [
            Text(
              'AppBundles',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 40),
            Text(
              'Your Bundles',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 10),
            if (bundles != null)
              bundles!.isEmpty
                  ? Text(
                      "You don't have any bundles yet",
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    )
                  : Wrap(
                      runSpacing: 20,
                      children: bundles!.map((e) => BundleCard(e)).toList(),
                    ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .pushNamed(RouteNames.appForm)
            .then((value) => setState(() {
                  _getBundles();
                })),
      ),
    );
  }
}
