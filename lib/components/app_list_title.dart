import 'package:app_bundles/components/app_icon_image.dart';
import 'package:app_bundles/models/app.dart';
import 'package:flutter/material.dart';

class AppListTitle extends StatefulWidget {
  final App app;
  final Function(bool)? onChanged;
  AppListTitle({required this.app, this.onChanged});

  @override
  _AppListTitleState createState() => _AppListTitleState();
}

class _AppListTitleState extends State<AppListTitle> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppIconImage(
        iconImage: widget.app.iconImage,
        size: 40,
      ),
      title: Text(
        '${widget.app.title}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: Icon(
        selected ? Icons.check_circle_outline : Icons.circle_rounded,
      ),
      onTap: () {
        setState(() => selected = !selected);
        if (widget.onChanged != null) widget.onChanged!(selected);
      },
    );
  }
}
