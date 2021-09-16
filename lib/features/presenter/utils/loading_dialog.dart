import 'package:flutter/material.dart';

Future<dynamic> loadingDialog({
  required BuildContext context,
  required Future<dynamic> Function() command,
}) async {
  return await showDialog<dynamic>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      command().then((dynamic data) => Navigator.pop(context, data));
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Center(child: CircularProgressIndicator()),
      );
    },
  );
}
