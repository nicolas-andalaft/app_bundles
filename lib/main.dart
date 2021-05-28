import 'package:app_bundles/models/route_names.dart';
import 'package:app_bundles/screens/app_form.dart';
import 'package:app_bundles/screens/app_list_screen.dart';
import 'package:app_bundles/screens/bundle_form.dart';
import 'package:app_bundles/screens/homepage.dart';
import 'package:app_bundles/utils/main_theme.dart';
import 'package:app_bundles/utils/shared_intent.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedIntent.listenIntent();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Bundles',
      theme: mainTheme(),
      initialRoute: '/home',
      routes: {
        RouteNames.home: (context) => Homepage(),
        RouteNames.appForm: (context) => AppForm(),
        RouteNames.appList: (context) => AppListScreen(),
        RouteNames.bundleForm: (context) => BundleForm(),
      },
    );
  }
}
