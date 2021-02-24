import 'package:app_bundles/models/route_names.dart';
import 'package:app_bundles/screens/app_form.dart';
import 'package:app_bundles/screens/app_list_screen.dart';
import 'package:app_bundles/screens/bundle_form.dart';
import 'package:app_bundles/screens/bundle_screen.dart';
import 'package:app_bundles/screens/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Bundles',
      theme: ThemeData.dark(),
      initialRoute: '/home',
      routes: {
        RouteNames.home: (context) => Homepage(),
        RouteNames.bundleApps: (context) => BundleScreen(),
        RouteNames.appForm: (context) => AppForm(),
        RouteNames.appList: (context) => AppListScreen(),
        RouteNames.bundleForm: (context) => BundleForm(),
      },
    );
  }
}
