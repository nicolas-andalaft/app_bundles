import 'package:universal_html/controller.dart';

import '../../features/domain/entities/app_entity.dart';

class PlayStoreScraper {
  static const String authority = 'play.google.com';
  static const String path = 'store/apps/details';

  static Future<AppEntity?> fromUrl(String url) async {
    final uri = Uri.parse(url);
    return await _getApp(uri);
  }

  static Future<AppEntity?> fromAppId(String appId) async {
    final uri = Uri.https(
      authority,
      path,
      {'id': appId},
    );
    return await _getApp(uri);
  }

  static Future<AppEntity?> _getApp(Uri uri) async {
    final controller = WindowController();
    await controller.openHttp(uri: uri).onError((error, stackTrace) => null);
    if (controller.window == null) return null;

    final imageElement = controller.window!.document
        .querySelector('div.oQ6oV > div.hkhL9e > div.xSyT2c > img');
    final titleElement =
        controller.window!.document.querySelector('h1.AHFaub > span');

    return AppEntity(
      title: titleElement?.innerText,
      iconUrl: imageElement?.attributes['src'],
    );
  }
}
