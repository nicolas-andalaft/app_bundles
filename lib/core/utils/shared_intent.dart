import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class SharedIntent {
  static String? _data;
  static String? get data {
    final temp = _data;
    _data = null;
    return temp;
  }

  static bool get hasData => _data != null;

  static void listenIntent() async {
    _data = await ReceiveSharingIntent.getInitialText();
  }
}
