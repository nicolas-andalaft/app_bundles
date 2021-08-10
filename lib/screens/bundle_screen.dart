import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/route_names.dart';
import 'package:app_bundles/utils/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:app_bundles/components/app_card.dart';
import 'package:app_bundles/database/app_dao.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:flutter/scheduler.dart';

class BundleScreen extends StatefulWidget {
  final Bundle bundle;
  BundleScreen(this.bundle);

  @override
  _BundleScreenState createState() => _BundleScreenState();
}

class _BundleScreenState extends State<BundleScreen> implements TickerProvider {
  List<App> appList = [];
  bool compact = true;

  void _getAppList() {
    AppDao.readFromBundle(widget.bundle).then(
      (value) => setState(() => appList = value),
    );
  }

  @override
  void initState() {
    _getAppList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Icon(widget.bundle.icon, size: 30),
                SizedBox(width: 5),
                Text(
                  widget.bundle.name!,
                  style: Theme.of(context).textTheme.headline1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    compact ? Icons.grid_view_sharp : Icons.apps,
                    size: 30,
                  ),
                  onPressed: () => setState(() => compact = !compact),
                ),
              ],
            ),
            SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: compact ? 4 : 3,
              childAspectRatio: 0.9,
              children: appList
                  .map(
                    (e) => AppCard(
                      app: e,
                      iconSize: compact ? 60 : 70,
                      onTap: () => showAppBottomSheet(context, e),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(RouteNames.appForm).then((data) {
          if (data != null) setState(() => _getAppList());
        }),
      ),
    );
  }

  @override
  Ticker createTicker(onTick) {
    return Ticker(onTick);
  }
}
