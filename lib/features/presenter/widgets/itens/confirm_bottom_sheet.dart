import 'package:flutter/material.dart';

class ConfirmBottomSheet extends StatelessWidget {
  final String? yesTitle;
  final String? noTitle;
  final Function()? yesFunction;
  final Function()? noFunction;
  ConfirmBottomSheet({
    this.yesTitle,
    this.yesFunction,
    this.noTitle,
    this.noFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              child: Text('$noTitle'),
              onPressed: noFunction,
            ),
          ),
          Expanded(
            child: ElevatedButton(
              child: Text('$yesTitle'),
              onPressed: yesFunction,
            ),
          ),
        ],
      ),
    );
  }
}
