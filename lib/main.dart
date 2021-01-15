import 'package:app_bundles/screens/app_form.dart';
import 'package:app_bundles/screens/app_list_screen.dart';
import 'package:app_bundles/screens/bundle_form.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Homepage(),
        '/appform': (context) => AppForm(),
        '/appform/appsearch': (context) => AppListScreen(),
        '/bundleform': (context) => BundleForm(),
      },
    );
  }
}
