import 'package:app_bundles/models/app.dart';
import 'package:flutter/material.dart';
import 'package:google_play_store_scraper_dart/google_play_store_scraper_dart.dart';

extension GooglePlayScraperDartExtension on GooglePlayScraperDart {
  Future<App> loadApp({@required String appID, String gl}) async {
    final String endpoint = '/store/apps/details?id=$appID&gl=$gl';

    final wasPageLoaded = await webScraper.loadWebPage(endpoint);
    if (!wasPageLoaded) {
      // Unable to retrieve app data from PlayStore
      throw ('Could not retrieve data from appID');
    }

    try {
      // Get title element
      final title = webScraper.getElement('title', []).first['title'];

      // Get icon url element
      final iconElement = webScraper.getElement(
          'div.oQ6oV > div.hkhL9e > div.xSyT2c > img', ['src', 'alt']);

      String icon = '';
      for (var element in iconElement) {
        if ((element['attributes']['alt']).toString().toLowerCase() ==
            'cover art') {
          icon = element['attributes']['src'];
        }
      }

      // Get store url element
      final url = 'https://play.google.com/store/apps/details?id=$appID&hl=en';

      // Return App object
      App app = App();
      app.appId = appID;
      app.title = title;
      app.iconUrl = icon;
      app.storeUrl = url;
      return app;
    } catch (error) {
      throw (error);
    }
  }
}
