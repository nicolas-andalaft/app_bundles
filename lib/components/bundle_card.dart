import 'package:app_bundles/models/bundle.dart';
import 'package:app_bundles/models/route_names.dart';
import 'package:flutter/material.dart';

class BundleCard extends StatelessWidget {
  final Bundle bundle;
  BundleCard(this.bundle);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                bundle.icon,
                size: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    bundle.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RouteNames.bundleForm),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        RouteNames.bundleApps,
        arguments: bundle,
      ),
    );
  }
}
