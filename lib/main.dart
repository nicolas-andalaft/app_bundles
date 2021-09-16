import 'package:flutter/material.dart';

import './core/utils/shared_intent.dart';
import './core/utils/route_names.dart';
import './features/presenter/pages/pages.dart';
import './features/presenter/utils/main_theme.dart';

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
      onGenerateTitle: (context) => "App Bundles",
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
